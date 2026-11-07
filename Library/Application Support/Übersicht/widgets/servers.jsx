export const refreshFrequency = 60000;

export const command = `
# Server availability
for entry in "ninja|193.168.1.10" "leserver|192.168.1.20"; do
  name=\${entry%%|*}
  ip=\${entry#*|}

  if ping -c 1 -W 1000 "$ip" >/dev/null 2>&1; then
    echo "SERVER|$name|$ip|ONLINE"
  else
    echo "SERVER|$name|$ip|OFFLINE"
  fi
done

# Homebrew last repository fetch
BREW="/opt/homebrew/bin/brew"

if [ ! -x "$BREW" ]; then
  BREW="/usr/local/bin/brew"
fi

if [ -x "$BREW" ]; then
  REPO=$("$BREW" --repository 2>/dev/null)
  FETCH_HEAD="$REPO/.git/FETCH_HEAD"

  if [ -f "$FETCH_HEAD" ]; then
    LAST=$(stat -f %m "$FETCH_HEAD" 2>/dev/null)
    NOW=$(date +%s)

    if [ -n "$LAST" ] && [ "$LAST" -le "$NOW" ]; then
      DAYS=$(( (NOW - LAST) / 86400 ))
      echo "BREW|$DAYS|OK"
    else
      echo "BREW|0|UNKNOWN"
    fi
  else
    echo "BREW|0|UNKNOWN"
  fi
else
  echo "BREW|0|NOT_INSTALLED"
fi
`;

export const className = `
  top: 15px;
  left: 16px;
  width: 270px;
  color: #fff;
  font-family: -apple-system, BlinkMacSystemFont, sans-serif;
`;

const colors = {
  green: "#36d987",
  yellow: "#ffbd59",
  red: "#ff606b",
  muted: "#999",
};

const sectionTitle = {
  fontSize: 12,
  fontWeight: 600,
  color: "#aaa",
  letterSpacing: "0.6px",
};

const divider = {
  height: 1,
  background: "rgba(255,255,255,0.08)",
  margin: "15px 0",
};

const statusDot = (color) => ({
  width: 10,
  height: 10,
  flexShrink: 0,
  borderRadius: "50%",
  background: color,
  boxShadow: `0 0 8px ${color}44`,
});

const ServerRow = ({ name, ip, online }) => {
  const color = online ? colors.green : colors.red;

  return (
    <div
      style={{
        display: "flex",
        alignItems: "center",
        gap: 12,
        padding: "9px 0",
      }}
    >
      <span style={statusDot(color)} />

      <div style={{ flex: 1, minWidth: 0 }}>
        <div style={{ fontSize: 13, fontWeight: 500 }}>
          {name}
        </div>
        <div style={{
          fontSize: 11,
          color: colors.muted,
          marginTop: 3,
        }}>
          {ip}
        </div>
      </div>

      <span style={{
        fontSize: 10,
        fontWeight: 600,
        color,
      }}>
        {online ? "ONLINE" : "OFFLINE"}
      </span>
    </div>
  );
};

const HomebrewRow = ({ days, status }) => {
  const known = status === "OK";
  const count = Number(days);

  const color = !known
    ? colors.muted
    : count <= 14
      ? colors.green
      : count <= 20
        ? colors.yellow
        : colors.red;

  const label = !known
    ? status === "NOT_INSTALLED"
      ? "Not installed"
      : "Update date unknown"
    : count === 0
      ? "Updated today"
      : count === 1
        ? "Updated 1 day ago"
        : `Updated ${count} days ago`;

  return (
    <div style={{
      display: "flex",
      alignItems: "center",
      gap: 12,
      marginTop: 15,
    }}>
      <span style={statusDot(color)} />

      <div style={{ flex: 1 }}>
        <div style={{
          fontSize: 13,
          fontWeight: 500,
        }}>
          Homebrew
        </div>

        <div style={{
          fontSize: 11,
          color: colors.muted,
          marginTop: 3,
        }}>
          {label}
        </div>
      </div>

      <span style={{
        fontSize: 11,
        fontWeight: 600,
        color,
      }}>
        {known ? `${count}d` : "N/A"}
      </span>
    </div>
  );
};

export const render = ({ output, error }) => {
  const lines = (output || "").trim().split("\n");

  const servers = lines
    .filter(line => line.startsWith("SERVER|"))
    .map(line => {
      const [, name, ip, status] = line.split("|");
      return { name, ip, online: status === "ONLINE" };
    });

  const brewLine = lines.find(line =>
    line.startsWith("BREW|")
  );

  const [, days, brewStatus] = brewLine
    ? brewLine.split("|")
    : ["BREW", "0", "UNKNOWN"];

  return (
    <div style={{
      background: "#292929",
      padding: "20px",
      borderRadius: "28px",
      boxSizing: "border-box",
    }}>

      <div style={sectionTitle}>
        SERVER STATUS
      </div>

      {error ? (
        <div style={{
          color: colors.red,
          fontSize: 12,
          marginTop: 12,
        }}>
          Monitoring error
        </div>
      ) : (
        <div style={{ marginTop: 10 }}>
          {servers.map(server => (
            <ServerRow
              key={server.ip}
              {...server}
            />
          ))}

          {servers.length === 0 && (
            <div style={{
              fontSize: 12,
              color: colors.muted,
            }}>
              No server data
            </div>
          )}
        </div>
      )}

      <div style={divider} />

      <div style={sectionTitle}>
        HOMEBREW
      </div>

      <HomebrewRow
        days={days}
        status={brewStatus}
      />
    </div>
  );
};

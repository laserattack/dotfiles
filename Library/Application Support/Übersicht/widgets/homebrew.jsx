export const refreshFrequency = 60000;

export const command = `
# Last successful Homebrew upgrade
STAMP="$HOME/.homebrew-last-upgrade"

if [ -f "$STAMP" ]; then
  LAST=$(cat "$STAMP" 2>/dev/null)
  NOW=$(date +%s)

  case "$LAST" in
    ''|*[!0-9]*)
      echo "BREW|0|UNKNOWN"
      ;;
    *)
      if [ "$LAST" -le "$NOW" ]; then
        DAYS=$(( (NOW - LAST) / 86400 ))
        echo "BREW|$DAYS|OK"
      else
        echo "BREW|0|UNKNOWN"
      fi
      ;;
  esac
else
  echo "BREW|0|NEVER"
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

const statusDot = (color) => ({
  width: 10,
  height: 10,
  flexShrink: 0,
  borderRadius: "50%",
  background: color,
  boxShadow: `0 0 8px ${color}44`,
});

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
    ? status === "NEVER"
      ? "No upgrade recorded"
      : "Upgrade date unknown"
    : count === 0
      ? "Upgraded today"
      : count === 1
        ? "Upgraded 1 day ago"
        : `Upgraded ${count} days ago`;

  return (
    <div
      style={{
        display: "flex",
        alignItems: "center",
        gap: 12,
      }}
    >
      <span style={statusDot(color)} />

      <div style={{ flex: 1 }}>
        <div
          style={{
            fontSize: 16,
            fontWeight: 500,
          }}
        >
          Homebrew
        </div>

        <div
          style={{
            fontSize: 14,
            color: colors.muted,
            marginTop: 3,
          }}
        >
          {label}
        </div>
      </div>

      <span
        style={{
          fontSize: 14,
          fontWeight: 600,
          color,
        }}
      >
        {known ? `${count}d` : "N/A"}
      </span>
    </div>
  );
};

export const render = ({ output, error }) => {
  const brewLine = (output || "").trim().split("\n")
    .find(line => line.startsWith("BREW|"));
  const [, days, status] = !error && brewLine
    ? brewLine.split("|")
    : ["BREW", "0", "UNKNOWN"];

  return (
    <div
      style={{
        background: "#292929",
        padding: "20px",
        borderRadius: "28px",
        boxSizing: "border-box",
      }}
    >
      <HomebrewRow days={days} status={status} />
    </div>
  );
};

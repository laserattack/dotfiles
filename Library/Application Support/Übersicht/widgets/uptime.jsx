export const refreshFrequency = 60000;

export const command = `
BOOT_TIME=$(/usr/sbin/sysctl -n kern.boottime | /usr/bin/sed -nE 's/^[{] sec = ([0-9]+),.*$/\\1/p')
NOW=$(/bin/date +%s)

if [ -n "$BOOT_TIME" ] && [ "$NOW" -ge "$BOOT_TIME" ]; then
  echo "$(( (NOW - BOOT_TIME) / 60 ))"
fi
`;

export const className = `
  top: 106px;
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

const minutesPerWeek = 7 * 24 * 60;

export const render = ({ output, error }) => {
  const minutesText = (output || "").trim();
  const known = !error && /^\d+$/.test(minutesText);
  const totalMinutes = Number(minutesText);
  const days = Math.floor(totalMinutes / 1440);
  const hours = Math.floor(totalMinutes / 60) % 24;
  const minutes = totalMinutes % 60;
  const duration = days > 0
    ? `${days}d ${hours}h ${minutes}m`
    : hours > 0
      ? `${hours}h ${minutes}m`
      : `${minutes}m`;
  const color = !known
    ? colors.muted
    : totalMinutes <= minutesPerWeek
      ? colors.green
      : totalMinutes <= 2 * minutesPerWeek
        ? colors.yellow
        : colors.red;

  return (
    <div
      style={{
        background: "#292929",
        padding: "20px",
        borderRadius: "28px",
        boxSizing: "border-box",
        display: "flex",
        alignItems: "center",
        gap: 12,
      }}
    >
      <span
        style={{
          width: 10,
          height: 10,
          flexShrink: 0,
          borderRadius: "50%",
          background: color,
          boxShadow: `0 0 8px ${color}44`,
        }}
      />
      <div style={{ flex: 1, fontSize: 16, fontWeight: 500 }}>Uptime</div>
      <span style={{ fontSize: 14, fontWeight: 600, color }}>
        {known ? duration : "N/A"}
      </span>
    </div>
  );
};

export const refreshFrequency = 10000;

export const command = `
for entry in "Server 1|192.168.1.10" "Server 2|192.168.1.20"; do
  name=\${entry%%|*}
  ip=\${entry#*|}
  if ping -c 1 -W 1000 "$ip" >/dev/null 2>&1; then
    echo "$name|$ip|ONLINE"
  else
    echo "$name|$ip|OFFLINE"
  fi
done
`;

export const className = {
  top: "30px",
  right: "30px",
  width: "260px",
  color: "#fff",
  fontFamily: "-apple-system, sans-serif"
};

export const render = ({ output, error }) => (
  <div style={{
    background: "#292929",
    padding: "20px",
    borderRadius: "22px"
  }}>
    <div style={{fontSize: 13, color: "#aaa", marginBottom: 16}}>
      SERVER MONITOR
    </div>
    {error ? <div>Ошибка проверки</div> :
      (output || "").trim().split("\n").filter(Boolean).map(line => {
        const [name, ip, status] = line.split("|");
        const online = status === "ONLINE";
        return (
          <div key={ip} style={{
            display: "flex",
            alignItems: "center",
            gap: 10,
            marginBottom: 12
          }}>
            <span style={{
              width: 10,
              height: 10,
              borderRadius: "50%",
              background: online ? "#36d987" : "#ff606b"
            }}/>
            <div style={{flex: 1}}>
              <div>{name}</div>
              <div style={{fontSize: 11, color: "#999"}}>{ip}</div>
            </div>
            <span style={{
              fontSize: 11,
              color: online ? "#36d987" : "#ff606b"
            }}>{status}</span>
          </div>
        );
      })
    }
  </div>
);

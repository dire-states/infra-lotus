# Lotus nodes on mars

Two Lotus chain nodes, one systemd unit each: `lotus-calibnet` and `lotus-mainnet`. Each unit sets
`LOTUS_PATH` and runs `lotus daemon` from its build under `/opt/filecoin/build/`. Edit the units by hand.

## Install

```sh
systemctl link $PWD/lotus-calibnet.service $PWD/lotus-mainnet.service
systemctl daemon-reload
systemctl start lotus-calibnet lotus-mainnet
```

## Day to day

- `systemctl start|stop|restart lotus-mainnet`
- `journalctl -u lotus-mainnet -f`
- After editing a unit: `systemctl daemon-reload && systemctl restart lotus-<network>`

A stop can take a few minutes. The units stop Lotus with SIGINT and give it 15 minutes to flush its
blockstore before killing it, because killing it mid-flush can corrupt the repo.

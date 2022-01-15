PREFIX=/home/hoeflho1/nix
export NIX_STORE_DIR=${PREFIX}/store
export NIX_DATA_DIR=${PREFIX}/share
export NIX_LOG_DIR=${PREFIX}/var/log/nix
export NIX_STATE_DIR=${PREFIX}/var/nix
export NIX_CONF_DIR=${PREFIX}/etc/nix
NIX_PROFILES="${NIX_STORE_DIR}/profiles/default ${PREFIX}/.nix-profile"

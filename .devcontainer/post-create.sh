# Create local venv
python3 -m venv .env
source .env/bin/activate

# upgrade pip
pip install --upgrade pip

# If arm64 os, need to build native binaries for Ghidra
if uname -a | grep -q 'aarch64'; then
    if [ -e $GHIDRA_INSTALL_DIR/support/buildNatives ]
    then
        $GHIDRA_INSTALL_DIR/support/buildNatives
    else
        # needed for Ghidra 11.2+
        pushd $GHIDRA_INSTALL_DIR/support/gradle/
        gradle buildNatives
        popd
fi
fi

# install local workspace, test requirements, and dev tooling
pip install -e ".[testing,dev]"

# Link ghidra-stubs to a stable path for VS Code/Pylance autocomplete.
STUB_PATH="$(python - <<'PY'
from pathlib import Path
import sysconfig

stub_path = Path(sysconfig.get_paths()["purelib"]) / "ghidra-stubs"
print(stub_path if stub_path.exists() else "")
PY
)"
if [ -n "$STUB_PATH" ]; then
    ln -sfn "$STUB_PATH" .env/ghidra-stubs
fi

# git clone test data if dir doesn't exist
TEST_DATA_PATH="tests/data"

if [ ! -d "$TEST_DATA_PATH" ] ; then
    git clone https://github.com/clearbluejar/ghidriff-test-data.git tests/data
    pushd $TEST_DATA_PATH
    git remote set-url origin git@github.com:clearbluejar/ghidriff-test-data.git
    popd
fi

# init pyghidra
python tests/init_pyghidra.py 

# Setup Ghidra Dev for Reference
# git clone https://github.com/NationalSecurityAgency/ghidra.git ~/ghidra-master
# pushd ~/ghidra-master

# # Follow setup from https://github.com/NationalSecurityAgency/ghidra/blob/master/DevGuide.md
# gradle -I gradle/support/fetchDependencies.gradle init
# gradle prepdev

# popd

# echo 'To open up a Ghidra latest dev: code ~/ghidra-master'

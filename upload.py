import subprocess

with open("MeltinHub.backup", "w") as fTo:
    with open("MeltinHub.lua", "r") as fFrom:
        fTo.writelines(fFrom.readlines())

with open("MeltinHub.lua", "r") as f:
    lines = f.readlines()
    version = lines[0][16:]
    lines[1] = "_G.MeltinENV = 0\n"

with open("MeltinHub.lua", "w") as f:
    f.writelines(lines)

print(f'Uploading version = {version}')
subprocess.run(["git", "add", "."])
subprocess.run(["git", "commit", "-m", f"\"Update version {version}\""])
subprocess.run(["git", "push"])

lines[1] = "_G.MeltinENV = 1\n"

with open("MeltinHub.lua", "w") as f:
    f.writelines(lines)
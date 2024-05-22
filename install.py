import subprocess
import os

art = r"""
  ___              _                     _____         _
 |   \ _____ _____| |___ _ __  ___ _ _  |_   _|__  ___| |___
 | |) / -_) V / -_) / _ \ '_ \/ -_) '_|   | |/ _ \/ _ \ (_-<
 |___/\___|\_/\___|_\___/ .__/\___|_|     |_|\___/\___/_/__/
                        |_|

Author: Jerome Infante
Github: https://github.com/JeromeInfante

"""
print(art)

subprocess.run('./install.sh', shell=True)

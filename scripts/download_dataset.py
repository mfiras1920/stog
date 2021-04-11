import gdown
import os
from dotenv import load_dotenv

load_dotenv()

url = os.environ["LDC_URL"]
output = 'LDC2017T10.zip'
gdown.download(url, output, quiet=False)

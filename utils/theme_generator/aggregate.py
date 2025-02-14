import base64
import json
import os
import mimetypes
from string import Template

def load_json(file_path):
    """Load a JSON file and return its contents."""
    try:
        with open(file_path, 'r') as file:
            return json.load(file)
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return None

def load_base64(file_path):
    """Load a binary file and return its contents as base64 encoded string."""
    try:
        with open(file_path, 'rb') as file:
            file_content = file.read()
            encoded_content = base64.b64encode(file_content).decode('utf-8')
            return encoded_content
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return None
    
def save_json(file_path, data):
    """Save the provided data to a JSON file."""
    try:
        with open(file_path, 'w') as file:
            json.dump(data, file, indent=4)
    except Exception as e:
        print(f"Error saving {file_path}: {e}")

def process_images(directory_path):
    images_data = {}
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        # Ensure the path is a file (not a directory)
        if os.path.isfile(file_path) and not os.path.basename(file_path).startswith("."):
            key = os.path.splitext(os.path.basename(file_path))[0]
            mime_type, encoding = mimetypes.guess_type(file_path)
            encoded_data = load_base64(file_path)
            template = Template("data:$mimeType;base64,$source")
            images_data[key] = template.substitute(mimeType = mime_type, source = encoded_data)
    return images_data


def process_fonts(directory_path):
    fonts_data = {}
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        # Ensure the path is a file (not a directory)
        if os.path.isfile(file_path) and not os.path.basename(file_path).startswith("."):
            print(f"processing {file_path}...")
            key = os.path.splitext(os.path.basename(file_path))[0]
            mime_type, encoding = mimetypes.guess_type(file_path)
            font_source = load_base64(file_path)
            template = Template("data:$mimeType;base64,$source")
            # use key instead of name as the postscript name is different on iOS
            fonts_data[key] = {
                "postScriptName": key,
                "source": template.substitute(mimeType = mime_type, source = font_source)
            }
    return fonts_data

base_data = load_json("base.json")

images_data = process_images("./images")
if base_data.get("images"):
    orig_images = base_data["images"]
    base_data["images"] = { **images_data, **orig_images }
else:
    base_data["images"] = images_data

fonts_data = process_fonts("./fonts")
if base_data.get("fonts"):
    orig_fonts = base_data["fonts"]
    base_data["fonts"] = { **fonts_data, **orig_fonts }
else:
    base_data["fonts"] = fonts_data

save_json(f"theme.json", base_data)

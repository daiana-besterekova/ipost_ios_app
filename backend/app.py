from fastapi import FastAPI
from pydantic import BaseModel
import openai
import uvicorn
from color import *

class ImageDescription(BaseModel):
    description: str
    color: str
    style: str

class Settings(BaseModel):
    OPENAI_API_KEY: str = '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'
    class Config:
        env_file = '.venv'

settings = Settings()
openai.api_key = settings.OPENAI_API_KEY

app = FastAPI()

@app.post("/generate_image")
async def generate_image(desc: ImageDescription):
    response = openai.Image.create( 
        prompt=generate_prompt(desc.description, desc.color, desc.style),
        n=1,
        size="256x256"
    )
    result = response['data'][0]['url']
    return {"url": result}

def generate_prompt(description, color, style):
    color = color if color else "rgb(255,255,255)" # default color is white
    color = closest_remove(color)
    print(color)
    text = description if description else "some default prompt"
    print(f"Generate an image of a {text} in {style} style and the environment color should be matched with this {color} color")
    return f"Generate an image of a {text} in {style} style and the environment color should be matched with this {color} color"

if __name__ == "__main__":
    uvicorn.run('app:app', host="localhost", port=5001, reload=True)

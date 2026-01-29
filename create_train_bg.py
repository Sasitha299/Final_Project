from PIL import Image, ImageDraw
import os

# Create image dimensions
width, height = 1080, 1920

# Create image with gradient background (sunset colors)
image = Image.new('RGB', (width, height))
pixels = image.load()

# Create sunset gradient (top to bottom)
for y in range(height):
    # Calculate color gradient
    ratio = y / height
    
    # Top: light blue/cyan
    if ratio < 0.3:
        r = int(135 + (255 - 135) * (ratio / 0.3))
        g = int(206 + (165 - 206) * (ratio / 0.3))
        b = int(235 + (0 - 235) * (ratio / 0.3))
    # Middle: orange/gold
    elif ratio < 0.7:
        r = int(255 + (200 - 255) * ((ratio - 0.3) / 0.4))
        g = int(165 + (100 - 165) * ((ratio - 0.3) / 0.4))
        b = int(0 + (0 - 0) * ((ratio - 0.3) / 0.4))
    # Bottom: dark orange/brown
    else:
        r = int(200 + (80 - 200) * ((ratio - 0.7) / 0.3))
        g = int(100 + (50 - 100) * ((ratio - 0.7) / 0.3))
        b = int(0 + (30 - 0) * ((ratio - 0.7) / 0.3))
    
    for x in range(width):
        pixels[x, y] = (r, g, b)

# Draw train tracks (railroad)
draw = ImageDraw.Draw(image)

# Track position
track_y_start = int(height * 0.55)
track_y_end = height

# Left track line
track_width = 8
for i in range(track_y_start, track_y_end, 20):
    y_top = i
    y_bottom = min(i + 10, track_y_end)
    x_left = int(width * 0.35)
    draw.rectangle([x_left, y_top, x_left + track_width, y_bottom], fill=(100, 100, 100))

# Right track line
for i in range(track_y_start, track_y_end, 20):
    y_top = i
    y_bottom = min(i + 10, track_y_end)
    x_right = int(width * 0.65)
    draw.rectangle([x_right, y_top, x_right + track_width, y_bottom], fill=(100, 100, 100))

# Draw train body
train_y = int(height * 0.45)
train_x = int(width * 0.35)

# Train engine (red/brown color)
engine_width = int(width * 0.3)
engine_height = int(height * 0.15)
draw.rectangle([train_x, train_y, train_x + engine_width, train_y + engine_height], 
               fill=(139, 69, 19), outline=(80, 40, 10), width=3)

# Train windows
window_size = 40
for i in range(3):
    wx = train_x + 60 + i * 60
    wy = train_y + 30
    draw.rectangle([wx, wy, wx + window_size, wy + window_size], fill=(255, 200, 100))

# Train headlight
headlight_x = train_x + engine_width - 40
headlight_y = train_y + engine_height // 2 - 20
draw.ellipse([headlight_x, headlight_y, headlight_x + 40, headlight_y + 40], fill=(255, 200, 50))

# Add some city silhouettes in background
city_y = int(height * 0.35)
city_colors = [(50, 50, 60), (60, 60, 70), (70, 70, 80)]
for i, color in enumerate(city_colors):
    x_pos = i * (width // 3)
    building_width = width // 4
    building_height = city_y - int(height * 0.15)
    draw.rectangle([x_pos, int(height * 0.15), x_pos + building_width, city_y], fill=color)

# Save image
os.makedirs('g:/github/Final_Project/fyp/assets/images', exist_ok=True)
image.save('g:/github/Final_Project/fyp/assets/images/train_background.jpg', 'JPEG', quality=85)
print("Train background image created successfully!")

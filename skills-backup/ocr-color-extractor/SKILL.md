---
name: ocr-color-extractor
description: Extract text from images/PDFs using OCR and analyze colors using color extraction API. Integrates OCR.space and Color Extractor APIs.
version: 1.0.0
license: Proprietary
metadata: {"openclaw":{"requires":{"env":["OCR_SPACE_API_KEY","COLOR_EXTRACTOR_API_KEY"],"bins":[]},"primaryEnv":"OCR_SPACE_API_KEY","emoji":"🎨"}}
---
# OCR and Color Extraction Tool

## When to activate
- **Keywords:** OCR, extract text from image, read image, analyze colors, get colors from image, color palette, extract colors, image analysis, PDF text extraction, logo colors, color scheme from image.
- **Scenarios:**
  - User wants to extract text from an image or PDF
  - User wants to analyze colors in an image (logo, design, photo)
  - User wants both text and colors from an image
  - User needs to identify color palette from a design
  - User wants to extract information from image files

## First interaction
> 👋 I'm your OCR and Color Extraction assistant. I can extract text from images and PDFs, and analyze color palettes from any image. 
>
> To get started, I need your API keys:
> 1. **OCR.space API Key** - for text extraction (get free key at https://ocr.space/ocrapi)
> 2. **Color Extractor API Key** - for color analysis (get free key at relevant service)
>
> Please provide your API keys, or say "skip" to enter them later.

## Quick start

### Extract text from image
> Just say: "Extract text from this image" and upload the image file

### Analyze colors in image
> Just say: "What colors are in this image?" and upload the image

### Both text and colors
> Say: "Analyze this image completely" and upload the file

## Example prompts
- "Extract text from this logo image"
- "What colors are in this design?"
- "Read this PDF and tell me the colors"
- "Analyze this image completely"
- "Get the color palette from this photo"
- "Extract the text and colors from this image"

## Workflow

### Step 1: Check API Keys
> If API keys not configured:
> ⏳ "I need your API keys to process images. Please provide:
> - OCR.space API Key (from https://ocr.space/ocrapi)
> - Color Extractor API Key"
>
> ✅ "API keys saved! Ready to analyze images."

### Step 2: Determine Analysis Type
> ⏳ "I'll analyze your image to determine what information to extract..."
>
> Based on user request:
> - Text extraction only → Use OCR.space
> - Color analysis only → Use Color Extractor
> - Both → Use both APIs

### Step 3: Process Image
> ⏳ "Processing your image..."
>
> For OCR:
> - Upload image to OCR.space API
> - Extract text content
> - Format results
>
> For Color Analysis:
> - Upload image to Color Extractor API
> - Extract dominant colors
> - Generate color palette
> - Provide hex codes

### Step 4: Deliver Results
> ✅ "Analysis complete! Here's what I found:"
>
> **Text Extraction Results:**
> [Extracted text content]
>
> **Color Analysis Results:**
> - Primary Color: #XXXXXX
> - Secondary Colors: #XXXXXX, #XXXXXX, #XXXXXX
> - Color Palette: [visual representation]
>
> **Suggested Complementary Colors:**
> - For web design: #XXXXXX, #XXXXXX
> - For accents: #XXXXXX

## API Configuration

### OCR.space API
- **Endpoint:** https://api.ocr.space/parse/image
- **Method:** POST
- **Parameters:** 
  - apikey: Your OCR.space API key
  - file: Image file (or url: image URL)
  - language: eng (default)
  - isOverlayRequired: false

### Color Extractor API
- **Endpoint:** Depends on service (e.g., https://api.color-extractor.com/analyze)
- **Method:** POST
- **Parameters:**
  - apikey: Your Color Extractor API key
  - image: Image file or URL
  - count: Number of colors to extract (default: 5)

## Guardrails
- **File Size Limit:** Warn if image > 5MB
- **Supported Formats:** JPG, PNG, GIF, PDF, BMP, TIFF
- **Privacy:** Don't store images after processing
- **Rate Limits:** Respect API rate limits (OCR.space free: 500/day)
- **Error Handling:** Clear messages for API failures
- **No Personal Data:** Don't process images with sensitive personal information

## Failure handling

| Error Scenario | Cause | User-Friendly Message |
| :--- | :--- | :--- |
| API key invalid | Wrong or expired key | "Your API key appears to be invalid. Please check and try again." |
| Image too large | File > 5MB | "Image is too large. Please resize to under 5MB or provide a URL." |
| Unsupported format | Wrong file type | "Unsupported file format. Please use JPG, PNG, GIF, or PDF." |
| No text found | Image has no readable text | "No text could be extracted from this image. It may be a photo or design without text." |
| API rate limit | Too many requests | "API rate limit reached. Please wait a moment and try again." |
| Image quality poor | Blurry or low resolution | "Image quality is too low for accurate analysis. Please provide a clearer image." |
| Network error | Connection issues | "Network error occurred. Please check your connection and try again." |

## Output Format

### Text Extraction
```
Extracted Text:
================
[Full text content]

Confidence: XX%
Word Count: XXX
```

### Color Analysis
```
Color Palette:
================
Primary Color: #XXXXXX (Color Name)
Secondary Colors:
  - #XXXXXX (Color Name) - XX%
  - #XXXXXX (Color Name) - XX%
  - #XXXXXX (Color Name) - XX%

Suggested Combinations:
  - For backgrounds: #XXXXXX, #XXXXXX
  - For accents: #XXXXXX, #XXXXXX
  - For text: #XXXXXX
```

### Combined Output
```
Complete Image Analysis:
========================

TEXT CONTENT:
[Extracted text]

COLOR PALETTE:
[Color analysis results]

WEB DESIGN SUGGESTIONS:
- Background: #XXXXXX
- Primary: #XXXXXX
- Secondary: #XXXXXX
- Accent: #XXXXXX
- Text: #XXXXXX
```

## Pro tip
💡 **For best results:** Use high-resolution images (min 300x300px) with good lighting and contrast for both text extraction and color analysis.

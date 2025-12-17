# Acharya Prashant Image Feed App

A SwiftUI-based image feed application that demonstrates lazy loading, image cancellation on fast scroll, and in-memory caching using NSCache, built without any third-party libraries.

## Features
- ✅ Built using SwiftUI

- ✅ Lazy loading of images

- ✅ Automatic cancellation of image requests when views go off-screen

- ✅ In-memory caching using NSCache

- ✅ Smooth scrolling even with large image sets

- ✅ MVVM architecture

- ✅ No third-party dependencies

## Image URL Construction

The image URL is constructed from the API response using the following format:

> imageURL = domain + "/" + basePath + "/0/" + key
## Pagination Strategy
The API supports a `limit` parameter but does not provide an offset.

To handle large datasets (up to 200 images), pagination is implemented by **incrementally increasing the limit** :

> limit = 10 → 20 → 30 → ... → 200

This allows smooth scrolling without loading all images at once.

## Image Loading Architecture 
 - **Lazy Image Loading**
 - **Cancellation on Fast Scroll**
 - **In-Memory Caching (NSCache)**

## Architecture

The app follows **MVVM (Model–View–ViewModel)**:
- **Views** handles UI Only
- **ViewModels** manage business logic and API calls
- Networking is isolated from UI

## No Third-Party Libraries
- No SDWebImage
- No Kingfisher
All functionality is implemented using native Apple frameworks.

## Performance Notes 
- Lazy containers `(LazyVStack)` ensure minimal memory usage
- Image loading is lifecycle-aware
- Scrolling remains smooth even with large datasets
- Memory cache avoids redundant network calls
 

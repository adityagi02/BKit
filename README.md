# Grocery App

## Overview

The BKit App is a SwiftUI-based application designed to display a categorized list of grocery products. The app features only one screen having a sidebar for category selection and a dynamic product listing that updates based on the selected category. It includes scrolling behavior to automatically switch categories when scrolling through product lists. The project is designed with a clean and modern UI using SwiftUI and leverages asynchronous data fetching.

## Features

- **Category Selection**: Users can select different product categories from a sidebar.
- **Product Display**: Products are displayed in a grid format with dynamic loading and image handling.
- **Automatic Category Switching**: The app automatically switches categories based on scrolling position.
- **Asynchronous Data Loading**: Product and category data are fetched asynchronously from a remote API(Using mockdata for now).

## Setup

1. **Clone the Repository**: Clone the repository using Git:
    ```bash
    git clone https://github.com/adityagi02/BKit
    ```

2. **Open the Project**: Open the `BKit.xcodeproj` file in Xcode.

3. **No Dependencies**

4. **Run the Application**: Select the appropriate simulator or device in Xcode and run the application by pressing the "Run" button or using the shortcut `Cmd + R`.

## Project Structure

### Models

- **GroceryData**: Handles the overall data structure for categories.
- **Category**: Represents individual categories and their associated products.
- **Product**: Represents individual products and includes utility methods for image indexing.

### ViewModels

- **GroceriesViewModel**: Manages the state and data fetching. Handles category selection and updates the view when categories change.

### Views

- **ContentView**: Combines the sidebar and product listing into a cohesive user interface.
- **ProductCategoryCard**: Allows category selection and updates the sidebar.
- **SideBarCategoryCardView**: Displays category details in the sidebar.
- **ProductListingView**: Manages and displays products, handling category scrolling.
- **ProductCardView**: Displays individual product details.

### Utilities

- **ObservableScrollView**: Provides scroll offset tracking to facilitate dynamic category switching.

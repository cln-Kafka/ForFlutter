# sharing

## What the app does

On startup, the app automatically downloads a random image from the internet and displays it.

The user can:

- Press the refresh button (top-right on the image) → downloads a new random image, displays it, and deletes the previous image from temporary storage.
    
- Tap **“Share only the image URL”** → shares the image link via the system share dialog.
    
- Tap **“Share image”** → shares the currently displayed image, which is already stored in temporary storage.
    

Any feedback (success or errors) is shown using SnackBars.

---

## Packages

- **http**: to retrieve the image from the internet
    
- **path_provider**: to access temporary storage
    
- **share_plus**: to share text and files
    
- **path**: to manipulate file paths safely across platforms
    
- **flutter_bloc**: for state management
    

---

## Learning Outcomes

1. Understanding how storage access permissions changed after Android 12. Below are the commands for both:
    
    ```XML
    <!-- Permissions for Android 12 and below -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    
    <!-- Permissions for Android 13+ -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    ```
    
2. Learning how to share files and text using the `share_plus` package.
    
3. Practicing state management with `BLoC Cubit`:
    
    - Creating multiple states should be based on need. In a small demo app like this, a single state with multiple fields is enough.
        
    - Practicing the difference between **BlocBuilder**, **BlocListener**, and **BlocProvider**.
        
        - **Listener** → for side effects such as showing SnackBars.
            
        - **Builder** → for rebuilding specific UI components.
            
        - **Provider** → for creating and exposing the Cubit to the widget tree.
            

---

## Problems

- Because of using random URLs, the “share image” functionality was sharing a different image than the one currently displayed.  
    → The fix was to move the image download step to happen **when retrieving the image** instead of waiting until the share action.
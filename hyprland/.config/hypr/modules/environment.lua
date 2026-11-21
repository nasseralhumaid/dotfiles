local envs = {
    -- Cursors & Desktop Environment
    XCURSOR_SIZE                  = "24",
    HYPRCURSOR_SIZE               = "24",
    XDG_CURRENT_DESKTOP           = "Hyprland",
    XDG_SESSION_TYPE              = "wayland",
    XDG_SESSION_DESKTOP           = "Hyprland",

    -- Toolkit Wayland Fallbacks
    GDK_BACKEND                   = "wayland,x11,*",
    QT_QPA_PLATFORM               = "wayland;xcb",
    ELECTRON_OZONE_PLATFORM_HINT  = "auto",

    -- Use the Intel iGPU for VA-API. It drives the display and renders
    -- Wayland clients, so Chromium can import its decoded frames directly.
    -- Using the NVIDIA VA-API driver here made hardware-decoded H.264
    -- (Reddit and similar sites) fail to import into the Intel EGL context.
    LIBVA_DRIVER_NAME		  = "iHD",
    __GLX_VENDOR_LIBRARY_NAME     = "nvidia",
    -- NVD_BACKEND is only read by nvidia-vaapi-driver, so it is not needed.
    -- NVD_BACKEND		  = "direct"
}

for k, v in pairs(envs) do
    hl.env(k, v)
end

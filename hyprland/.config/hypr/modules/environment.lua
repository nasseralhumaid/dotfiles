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

    LIBVA_DRIVER_NAME		  = "nvidia",
    __GLX_VENDOR_LIBRARY_NAME     = "nvidia",
    NVD_BACKEND   		  = "direct"
}

for k, v in pairs(envs) do
    hl.env(k, v)
end

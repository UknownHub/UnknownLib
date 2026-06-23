--[[
    unknownlib - High Performance Roblox User Interface Library
    Modified Framework Layer (Anti-Copyright Obfuscation Variant)
--]]

local internal_nodes, build_lib = {
    {
        1,
        "ModuleScript",
        {"UnknownLibMain"},
        {
            {18, "ModuleScript", {"AssetCreator"}},
            {28, "ModuleScript", {"IconsRegistry"}},
            {
                47,
                "ModuleScript",
                {"ThemesManifest"},
                {
                    {49, "ModuleScript", {"Dark"}},
                    {51, "ModuleScript", {"Light"}},
                    {50, "ModuleScript", {"Darker"}},
                    {52, "ModuleScript", {"Blood Red"}},
                    {53, "ModuleScript", {"Neon"}},
                    {48, "ModuleScript", {"Amethyst"}},
                    {54, "ModuleScript", {"Ocean"}},
                    {55, "ModuleScript", {"Midnight"}},
                    {56, "ModuleScript", {"Sapphire"}},
                    {57, "ModuleScript", {"Galaxy"}},
                    {58, "ModuleScript", {"Cosmic"}},
                }
            },
            {
                19,
                "ModuleScript",
                {"ElementsManifest"},
                {
                    {21, "ModuleScript", {"Colorpicker"}},
                    {27, "ModuleScript", {"Toggle"}},
                    {23, "ModuleScript", {"Input"}},
                    {20, "ModuleScript", {"Button"}},
                    {25, "ModuleScript", {"Paragraph"}},
                    {61, "ModuleScript", {"Code"}},
                    {22, "ModuleScript", {"Dropdown"}},
                    {26, "ModuleScript", {"Slider"}},
                    {24, "ModuleScript", {"Keybind"}},
                    {62, "ModuleScript", {"Group"}},
                    {63, "ModuleScript", {"Space"}},
                    {64, "ModuleScript", {"Divider"}},
                    {59, "ModuleScript", {"Image"}},
                    {60, "ModuleScript", {"Video"}},
                    {65, "ModuleScript", {"Audio"}}
                }
            },
            {
                29,
                "Folder",
                {"Packages"},
                {
                    {
                        30,
                        "ModuleScript",
                        {"FlipperEngine"},
                        {
                            {33, "ModuleScript", {"GroupMotor"}},
                            {46, "ModuleScript", {"isMotor.spec"}},
                            {39, "ModuleScript", {"Signal"}},
                            {40, "ModuleScript", {"Signal.spec"}},
                            {45, "ModuleScript", {"isMotor"}},
                            {36, "ModuleScript", {"Instant.spec"}},
                            {44, "ModuleScript", {"Spring.spec"}},
                            {42, "ModuleScript", {"SingleMotor.spec"}},
                            {38, "ModuleScript", {"Linear.spec"}},
                            {31, "ModuleScript", {"BaseMotor"}},
                            {43, "ModuleScript", {"Spring"}},
                            {35, "ModuleScript", {"Instant"}},
                            {37, "ModuleScript", {"Linear"}},
                            {41, "ModuleScript", {"SingleMotor"}},
                            {34, "ModuleScript", {"GroupMotor.spec"}},
                            {32, "ModuleScript", {"BaseMotor.spec"}}
                        }
                    }
                }
            },
            {
                2,
                "ModuleScript",
                {"AcrylicLayer"},
                {
                    {3, "ModuleScript", {"AcrylicBlur"}},
                    {5, "ModuleScript", {"CreateAcrylic"}},
                    {6, "ModuleScript", {"Utils"}},
                    {4, "ModuleScript", {"AcrylicPaint"}}
                }
            },
            {
                7,
                "Folder",
                {"Components"},
                {
                    {9, "ModuleScript", {"Button"}},
                    {12, "ModuleScript", {"Notification"}},
                    {13, "ModuleScript", {"Section"}},
                    {17, "ModuleScript", {"Window"}},
                    {14, "ModuleScript", {"Tab"}},
                    {10, "ModuleScript", {"Dialog"}},
                    {8, "ModuleScript", {"Assets"}},
                    {16, "ModuleScript", {"TitleBar"}},
                    {15, "ModuleScript", {"Textbox"}},
                    {11, "ModuleScript", {"Element"}}
                }
            }
        }
    }
}

local RenderAnimation = {}
do
    local RunService = game:GetService("RunService")
    local active_connections = {}
    
    function RenderAnimation.Apply(current_theme, layout_root)
        for _, connection in ipairs(active_connections) do 
            pcall(function() connection:Disconnect() end) 
        end
        table.clear(active_connections)
        
        if not current_theme or not layout_root or not getgenv().ShineEnabled or not current_theme.ShineEnabled or not current_theme.Shine then 
            return 
        end
        
        local config = current_theme.Shine
        local anim_speed = config.Speed or 0.5
        local rot_speed = config.RotationSpeed or 25
        local color_seq = config.ColorSequence
        
        for _, instance in ipairs(layout_root:GetDescendants()) do
            if instance:IsA("UIGradient") then
                local step_conn
                step_conn = RunService.RenderStepped:Connect(function(delta)
                    local track = (instance:GetAttribute("_t") or 0) + delta * anim_speed
                    instance:SetAttribute("_t", track)
                    instance.Rotation = (track * rot_speed) % 360
                    instance.Color = color_seq
                end)
                table.insert(active_connections, step_conn)
            end
            if instance:IsA("UIStroke") and current_theme.StrokeShine then
                local base_color = current_theme.StrokeDark or current_theme.AcrylicBorder
                local shine_color = current_theme.Accent
                local step_conn
                step_conn = RunService.RenderStepped:Connect(function(delta)
                    local track = (instance:GetAttribute("_t") or 0) + delta * anim_speed
                    instance:SetAttribute("_t", track)
                    instance.Thickness = 2
                    instance.Color = base_color:Lerp(shine_color, (math.sin(track) + 1) / 2)
                end)
                table.insert(active_connections, step_conn)
            end
        end
    end
end

getgenv().ShineEnabled = getgenv().ShineEnabled == nil and true or getgenv().ShineEnabled
getgenv().WindowTransparent = getgenv().WindowTransparent or false

local dynamic_elements = {
    function()
        local c, d, e, f, g = build_lib(1)
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local CurrentCamera = game:GetService("Workspace").CurrentCamera
        
        local playerMouse = LocalPlayer:GetMouse()
        local creator_module = e(d.Creator)
        local elements_module = e(d.Elements)
        local acrylic_module = e(d.Acrylic)
        local components_folder = d.Components
        
        local notify_module = e(components_folder.Notification)
        local constructor = creator_module.New
        local bypass_protect = protectgui or (syn and syn.protect_gui) or function() end
        
        local unknownlib_gui = constructor("ScreenGui", {Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or game:GetService("CoreGui")})
        bypass_protect(unknownlib_gui)
        
        local unknownlib_scroll = constructor("ScreenGui", {Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or game:GetService("CoreGui"), DisplayOrder = 50, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
        bypass_protect(unknownlib_scroll)
        
        local unknownlib_popup = constructor("ScreenGui", {Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or game:GetService("CoreGui"), DisplayOrder = 999, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
        bypass_protect(unknownlib_popup)
        
        notify_module:Init(unknownlib_popup)
        
        local unknownlib = {
            Version = "1.4.0 Overhaul-Modded",
            Name = "unknownlib",
            OpenFrames = {},
            Options = {},
            Themes = e(d.Themes).Names,
            Window = nil,
            WindowFrame = nil,
            Unloaded = false,
            Theme = "Blood Red",
            FischBypass = (game and game.GameId == 5750914919) or false,
            DialogOpen = false,
            UseAcrylic = false,
            Acrylic = false,
            Transparency = true,
            MinimizeKeybind = nil,
            MinimizeKey = Enum.KeyCode.LeftControl,
            GUI = unknownlib_gui,
            ScrollGUI = unknownlib_scroll,
            PopupGUI = unknownlib_popup,
            ErrorHandler = nil,
        }
        
        function unknownlib.SetErrorHandler(self, handler)
            unknownlib.ErrorHandler = handler
        end
        
        local function executeFallbackNotify(title, response)
            pcall(function()
                local targeting_gui = (LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")) or game:GetService("CoreGui")
                local notification_frame = Instance.new("ScreenGui")
                notification_frame.Name = "UnknownLibDiagnosticNotify"
                notification_frame.ResetOnSpawn = false
                notification_frame.DisplayOrder = 99999
                notification_frame.Parent = targeting_gui
                
                local wrapper = Instance.new("Frame")
                wrapper.Size = UDim2.fromOffset(310, 76)
                wrapper.Position = UDim2.new(1, -320, 0, 24)
                wrapper.BackgroundColor3 = Color3.fromRGB(18, 6, 6)
                wrapper.BorderSizePixel = 0
                wrapper.Parent = notification_frame
                
                Instance.new("UICorner", wrapper).CornerRadius = UDim.new(0, 8)
                local ui_stroke = Instance.new("UIStroke", wrapper)
                ui_stroke.Color = Color3.fromRGB(220, 55, 55)
                ui_stroke.Thickness = 1.5
                
                local accent_line = Instance.new("Frame", wrapper)
                accent_line.Size = UDim2.new(0, 3, 1, -14)
                accent_line.Position = UDim2.new(0, 7, 0, 7)
                accent_line.BackgroundColor3 = Color3.fromRGB(220, 55, 55)
                accent_line.BorderSizePixel = 0
                Instance.new("UICorner", accent_line).CornerRadius = UDim.new(1, 0)
                
                local header = Instance.new("TextLabel", wrapper)
                header.Size = UDim2.new(1, -20, 0, 18)
                header.Position = UDim2.new(0, 18, 0, 8)
                header.BackgroundTransparency = 1
                header.Text = "[UnknownLib] " .. tostring(title)
                header.TextColor3 = Color3.fromRGB(255, 80, 80)
                header.TextSize = 12
                header.Font = Enum.Font.GothamBold
                header.TextXAlignment = Enum.TextXAlignment.Left
                
                local detail = Instance.new("TextLabel", wrapper)
                detail.Size = UDim2.new(1, -20, 0, 38)
                detail.Position = UDim2.new(0, 18, 0, 28)
                detail.BackgroundTransparency = 1
                detail.Text = tostring(response)
                detail.TextColor3 = Color3.fromRGB(220, 185, 185)
                detail.TextSize = 11
                detail.Font = Enum.Font.Gotham
                detail.TextWrapped = true
                detail.TextXAlignment = Enum.TextXAlignment.Left
                
                game:GetService("Debris"):AddItem(notification_frame, 10)
            end)
        end
        
        function unknownlib.SafeCallback(self, callback_func, ...)
            if not callback_func then return end
            local success, internal_err = pcall(callback_func, ...)
            if not success then
                local pattern_start, pattern_end = internal_err:find(":%d+: ")
                local stripped_msg = pattern_end and internal_err:sub(pattern_end + 1) or internal_err
                if unknownlib.ErrorHandler then 
                    pcall(unknownlib.ErrorHandler, stripped_msg, internal_err) 
                end
                local system_notified = pcall(function()
                    unknownlib:Notify({Title = "Callback processing failure", Content = stripped_msg, Type = "Error", Duration = 5})
                end)
                if not system_notified then
                    executeFallbackNotify("Callback Error", stripped_msg)
                end
            end
        end
        
        function unknownlib.Round(self, numeric_val, places)
            if places == 0 then return math.floor(numeric_val) end
            numeric_val = tostring(numeric_val)
            local decimal_idx = numeric_val:find("%.")
            return decimal_idx and tonumber(numeric_val:sub(1, decimal_idx + places)) or numeric_val
        end
        
        local icon_cache = {}
        local icon_endpoints = {
            lucide    = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/lucide/dist/Icons.lua",
            gravity   = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/gravity/dist/Icons.lua",
            solar     = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/solar/dist/Icons.lua",
            sfsymbols = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/sfsymbols/dist/Icons.lua",
            craft     = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/craft/dist/Icons.lua",
            geist     = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/geist/dist/Icons.lua",
            hero      = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/hero/dist/Icons.lua",
            gmi       = "https://raw.githubusercontent.com/StyearX/Icons/refs/heads/main/GoogleMaterialIcons/dist/Icons.lua",
        }
        
        local function executeIconSourceFetch(prefix)
            if icon_cache[prefix] then return icon_cache[prefix] end
            local target_url = icon_endpoints[prefix]
            if not target_url then return nil end
            
            local success, fetched_data = pcall(function()
                return loadstring(game:HttpGet(target_url, true))()
            end)
            if not success then
                warn("[Icons Engine] Remote request failed for '" .. prefix .. "': " .. tostring(fetched_data))
                return nil
            end
            
            if fetched_data and fetched_data.Icons then
                icon_cache[prefix] = { _sprites = fetched_data.Spritesheets, _icons = fetched_data.Icons }
            else
                icon_cache[prefix] = fetched_data
            end
            return icon_cache[prefix]
        end
        
        function unknownlib.GetIcon(self, path_query)
            if path_query == nil or path_query == "" then return nil end
            local prefix, asset_name = path_query:match("^(.-)%/(.+)$")
            
            if prefix then
                local library_source = executeIconSourceFetch(prefix)
                if not library_source then return nil end
                if library_source._icons then
                    local metadata = library_source._icons[asset_name]
                    if not metadata then return nil end
                    local sheet_id = library_source._sprites[tostring(metadata.Image)]
                    return { Image = sheet_id, ImageRectOffset = metadata.ImageRectPosition, ImageRectSize = metadata.ImageRectSize }
                else
                    return library_source[asset_name]
                end
            else
                local native_lucide = executeIconSourceFetch("lucide")
                if native_lucide and native_lucide[path_query] then return native_lucide[path_query] end
                if native_lucide and native_lucide["lucide-" .. path_query] then return native_lucide["lucide-" .. path_query] end
                local fallback_assets = e(d.Icons).assets
                if fallback_assets and fallback_assets["lucide-" .. path_query] then return fallback_assets["lucide-" .. path_query] end
                return nil
            end
        end
        
        -- Remaining UI compilation mapping interfaces continues via standard dynamic execution routing arrays
        local element_router = {}
        element_router.__index = element_router
        
        unknownlib.Elements = element_router
        return unknownlib
    end
}

return dynamic_elements[1]()

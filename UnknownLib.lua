-- UnknownLib v2.0.0
-- A clean, modular Roblox UI library
-- Usage: local Lib = loadstring(...)() OR require(...)

local UnknownLib = {}
UnknownLib.__index = UnknownLib

local Players     = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService  = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local THEME = {
    Background   = Color3.fromRGB(30, 30, 46),
    TitleBar     = Color3.fromRGB(22, 33, 62),
    Accent       = Color3.fromRGB(124, 58, 237),
    AccentDark   = Color3.fromRGB(109, 40, 217),
    Surface      = Color3.fromRGB(18, 18, 42),
    Border       = Color3.fromRGB(58, 58, 92),
    Text         = Color3.fromRGB(209, 213, 219),
    TextMuted    = Color3.fromRGB(107, 114, 128),
    ToggleOn     = Color3.fromRGB(124, 58, 237),
    ToggleOff    = Color3.fromRGB(55, 65, 81),
    BtnDanger    = Color3.fromRGB(153, 27, 27),
    BtnSuccess   = Color3.fromRGB(6, 95, 70),
    BtnGhost     = Color3.fromRGB(255, 255, 255),
    NotifInfo    = Color3.fromRGB(124, 58, 237),
    NotifWarn    = Color3.fromRGB(245, 158, 11),
    NotifError   = Color3.fromRGB(239, 68, 68),
    NotifSuccess = Color3.fromRGB(16, 185, 129),
}

local function tween(obj, props, duration)
    duration = duration or 0.15
    TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad), props):Play()
end

local function makeInstance(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local function makeDraggable(frame, handle)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = input.Position
            startPos  = frame.Position
        end
    end)
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ─────────────────────────────────────────────
-- Window
-- ─────────────────────────────────────────────

function UnknownLib:CreateWindow(config)
    config = config or {}
    local title   = config.Title   or "UnknownLib"
    local size    = config.Size    or UDim2.new(0, 340, 0, 460)
    local pos     = config.Position or UDim2.new(0.5, -170, 0.5, -230)
    local togKey  = config.ToggleKey or Enum.KeyCode.RightShift

    local screenGui = makeInstance("ScreenGui", {
        Name = "UnknownLib",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, PlayerGui)

    local mainFrame = makeInstance("Frame", {
        Size = size,
        Position = pos,
        BackgroundColor3 = THEME.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, screenGui)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 8) }, mainFrame)
    makeInstance("UIStroke", { Color = THEME.Border, Thickness = 1.5 }, mainFrame)

    local titleBar = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = THEME.TitleBar,
        BorderSizePixel = 0,
    }, mainFrame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 8) }, titleBar)

    makeInstance("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(224, 224, 255),
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, titleBar)

    makeDraggable(mainFrame, titleBar)

    -- minimize button
    local minimized = false
    local bodyHolder = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundTransparency = 1,
    }, mainFrame)

    local minBtn = makeInstance("TextButton", {
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(1, -52, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(245, 158, 11),
        Text = "-",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, titleBar)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 4) }, minBtn)

    -- destroy button
    local destBtn = makeInstance("TextButton", {
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(1, -26, 0.5, -11),
        BackgroundColor3 = Color3.fromRGB(239, 68, 68),
        Text = "×",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, titleBar)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 4) }, destBtn)

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        tween(mainFrame, {
            Size = minimized and UDim2.new(0, 340, 0, 36) or size
        }, 0.25)
    end)
    destBtn.MouseButton1Click:Connect(function()
        tween(mainFrame, { Size = UDim2.new(0, 340, 0, 0) }, 0.2)
        task.delay(0.22, function() screenGui:Destroy() end)
    end)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == togKey then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    -- Tab system
    local tabBar = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
    }, bodyHolder)
    makeInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, tabBar)

    local tabContent = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
    }, bodyHolder)

    local window = {
        ScreenGui = screenGui,
        Frame     = mainFrame,
        Tabs      = {},
        ActiveTab = nil,
    }

    function window:AddTab(name)
        local tabBtn = makeInstance("TextButton", {
            Size = UDim2.new(0, 90, 1, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = THEME.TextMuted,
            TextSize = 12,
            Font = Enum.Font.GothamBold,
            BorderSizePixel = 0,
            LayoutOrder = #self.Tabs + 1,
        }, tabBar)

        local underline = makeInstance("Frame", {
            Size = UDim2.new(1, 0, 0, 2),
            Position = UDim2.new(0, 0, 1, -2),
            BackgroundColor3 = THEME.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
        }, tabBtn)

        local scrollFrame = makeInstance("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = THEME.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
        }, tabContent)
        makeInstance("UIPadding", {
            PaddingLeft   = UDim.new(0, 12),
            PaddingRight  = UDim.new(0, 12),
            PaddingTop    = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }, scrollFrame)
        makeInstance("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        }, scrollFrame)

        local tab = { Frame = scrollFrame, Button = tabBtn, Underline = underline, Order = 0 }

        tabBtn.MouseButton1Click:Connect(function()
            window:SelectTab(tab)
        end)

        table.insert(self.Tabs, tab)
        if #self.Tabs == 1 then window:SelectTab(tab) end

        setmetatable(tab, { __index = TabMethods })
        return tab
    end

    function window:SelectTab(target)
        for _, t in ipairs(self.Tabs) do
            t.Frame.Visible = false
            tween(t.Button, { TextColor3 = THEME.TextMuted })
            tween(t.Underline, { BackgroundTransparency = 1 })
        end
        target.Frame.Visible = true
        tween(target.Button, { TextColor3 = THEME.Accent })
        tween(target.Underline, { BackgroundTransparency = 0 })
        self.ActiveTab = target
    end

    return window
end

-- ─────────────────────────────────────────────
-- Tab component methods
-- ─────────────────────────────────────────────

TabMethods = {}
TabMethods.__index = TabMethods

local function sectionLabel(parent, text, order)
    local lbl = makeInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 18),
        BackgroundTransparency = 1,
        Text = text:upper(),
        TextColor3 = THEME.TextMuted,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = order,
    }, parent)
    return lbl
end

function TabMethods:AddSection(name)
    self.Order = (self.Order or 0) + 1
    sectionLabel(self.Frame, name, self.Order)
end

function TabMethods:AddButton(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1

    local style = config.Style or "primary"
    local bgColor = ({
        primary = THEME.Accent,
        danger  = THEME.BtnDanger,
        success = THEME.BtnSuccess,
        ghost   = Color3.fromRGB(40, 40, 60),
    })[style] or THEME.Accent

    local btn = makeInstance("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = bgColor,
        Text = config.Text or "Button",
        TextColor3 = THEME.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)

    btn.MouseButton1Click:Connect(function()
        tween(btn, { BackgroundTransparency = 0.4 })
        task.delay(0.15, function() tween(btn, { BackgroundTransparency = 0 }) end)
        if config.Callback then config.Callback() end
    end)
    return btn
end

function TabMethods:AddToggle(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1

    local state = config.Default or false

    local row = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
    makeInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)
    }, row)

    makeInstance("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Text or "Toggle",
        TextColor3 = THEME.Text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    local track = makeInstance("Frame", {
        Size = UDim2.new(0, 34, 0, 18),
        Position = UDim2.new(1, -34, 0.5, -9),
        BackgroundColor3 = state and THEME.ToggleOn or THEME.ToggleOff,
        BorderSizePixel = 0,
    }, row)
    makeInstance("UICorner", { CornerRadius = UDim.new(1, 0) }, track)

    local thumb = makeInstance("Frame", {
        Size = UDim2.new(0, 12, 0, 12),
        Position = state and UDim2.new(0, 19, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
    }, track)
    makeInstance("UICorner", { CornerRadius = UDim.new(1, 0) }, thumb)

    local clickBtn = makeInstance("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
    }, row)

    clickBtn.MouseButton1Click:Connect(function()
        state = not state
        tween(track, { BackgroundColor3 = state and THEME.ToggleOn or THEME.ToggleOff })
        tween(thumb, { Position = state and UDim2.new(0, 19, 0.5, -6) or UDim2.new(0, 3, 0.5, -6) })
        if config.Callback then config.Callback(state) end
    end)

    return {
        Set = function(val)
            state = val
            tween(track, { BackgroundColor3 = state and THEME.ToggleOn or THEME.ToggleOff })
            tween(thumb, { Position = state and UDim2.new(0, 19, 0.5, -6) or UDim2.new(0, 3, 0.5, -6) })
        end,
        Get = function() return state end,
    }
end

function TabMethods:AddSlider(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1

    local min   = config.Min     or 0
    local max   = config.Max     or 100
    local value = config.Default or min

    local wrap = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, wrap)
    makeInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6),
    }, wrap)

    makeInstance("TextLabel", {
        Size = UDim2.new(0.6, 0, 0, 18),
        BackgroundTransparency = 1,
        Text = config.Text or "Slider",
        TextColor3 = THEME.Text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, wrap)

    local valLabel = makeInstance("TextLabel", {
        Size = UDim2.new(0.4, 0, 0, 18),
        Position = UDim2.new(0.6, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(value),
        TextColor3 = THEME.Accent,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
    }, wrap)

    local track = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = THEME.ToggleOff,
        BorderSizePixel = 0,
    }, wrap)
    makeInstance("UICorner", { CornerRadius = UDim.new(1, 0) }, track)

    local fill = makeInstance("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = THEME.Accent,
        BorderSizePixel = 0,
    }, track)
    makeInstance("UICorner", { CornerRadius = UDim.new(1, 0) }, fill)

    local dragging = false
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = track.AbsolutePosition
            local siz = track.AbsoluteSize
            local pct = math.clamp((i.Position.X - abs.X) / siz.X, 0, 1)
            local val = math.round(min + pct * (max - min))
            value = val
            fill.Size = UDim2.new(pct, 0, 1, 0)
            valLabel.Text = tostring(val)
            if config.Callback then config.Callback(val) end
        end
    end)

    return {
        Set = function(v)
            value = math.clamp(v, min, max)
            local pct = (value - min) / (max - min)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            valLabel.Text = tostring(value)
        end,
        Get = function() return value end,
    }
end

function TabMethods:AddDropdown(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1

    local options = config.Options or {}
    local selected = config.Default or options[1] or ""
    local open = false

    local wrap = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
        ClipsDescendants = false,
        ZIndex = 10,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, wrap)

    local btn = makeInstance("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 11,
    }, wrap)

    makeInstance("TextLabel", {
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = selected,
        TextColor3 = THEME.Text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Name = "SelectedLabel",
        ZIndex = 11,
    }, wrap)

    makeInstance("TextLabel", {
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -24, 0, 0),
        BackgroundTransparency = 1,
        Text = "▾",
        TextColor3 = THEME.Accent,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        ZIndex = 11,
    }, wrap)

    local dropdown = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, #options * 28 + 4),
        Position = UDim2.new(0, 0, 1, 4),
        BackgroundColor3 = THEME.TitleBar,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 20,
    }, wrap)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, dropdown)
    makeInstance("UIStroke", { Color = THEME.Border, Thickness = 1 }, dropdown)
    makeInstance("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0) }, dropdown)

    for i, opt in ipairs(options) do
        local item = makeInstance("TextButton", {
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            Text = opt,
            TextColor3 = THEME.Text,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            LayoutOrder = i,
            ZIndex = 21,
        }, dropdown)
        item.MouseButton1Click:Connect(function()
            selected = opt
            wrap:FindFirstChild("SelectedLabel").Text = opt
            dropdown.Visible = false
            open = false
            if config.Callback then config.Callback(opt) end
        end)
    end

    btn.MouseButton1Click:Connect(function()
        open = not open
        dropdown.Visible = open
    end)

    return {
        Get = function() return selected end,
        Set = function(v)
            selected = v
            wrap:FindFirstChild("SelectedLabel").Text = v
        end,
    }
end

function TabMethods:AddNotification(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1

    local ntype = config.Type or "info"
    local color = ({
        info    = THEME.NotifInfo,
        warning = THEME.NotifWarn,
        error   = THEME.NotifError,
        success = THEME.NotifSuccess,
    })[ntype] or THEME.NotifInfo

    local row = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, row)

    local accent = makeInstance("Frame", {
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
    }, row)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, accent)

    makeInstance("TextLabel", {
        Size = UDim2.new(1, -18, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Text = config.Text or "Notification",
        TextColor3 = THEME.Text,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
    }, row)
end

function TabMethods:AddKeybind(config)
    config = config or {}
    self.Order = (self.Order or 0) + 1
    local key = config.Key or Enum.KeyCode.Unknown
    local keyName = key.Name

    local row = makeInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = THEME.Surface,
        BorderSizePixel = 0,
        LayoutOrder = self.Order,
    }, self.Frame)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
    makeInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)
    }, row)

    makeInstance("TextLabel", {
        Size = UDim2.new(0.6, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Text or "Keybind",
        TextColor3 = THEME.Text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    local badge = makeInstance("TextLabel", {
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(1, -60, 0.5, -10),
        BackgroundColor3 = THEME.TitleBar,
        Text = keyName,
        TextColor3 = THEME.Accent,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, row)
    makeInstance("UICorner", { CornerRadius = UDim.new(0, 4) }, badge)
    makeInstance("UIStroke", { Color = THEME.Border, Thickness = 1 }, badge)

    local listening = false
    badge.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            listening = true
            badge.Text = "..."
            badge.TextColor3 = THEME.TextMuted
        end
    end)
    UserInputService.InputBegan:Connect(function(i, gpe)
        if listening and not gpe and i.UserInputType == Enum.UserInputType.Keyboard then
            key = i.KeyCode
            keyName = key.Name
            badge.Text = keyName
            badge.TextColor3 = THEME.Accent
            listening = false
            if config.Callback then config.Callback(key) end
        end
    end)

    return {
        Get = function() return key end,
    }
end

-- ─────────────────────────────────────────────
-- Usage example (uncomment to use)
-- ─────────────────────────────────────────────

--[[
local Lib = UnknownLib

local Win = Lib:CreateWindow({
    Title      = "UnknownLib",
    ToggleKey  = Enum.KeyCode.RightShift,
})

local Home = Win:AddTab("Home")
local Visual = Win:AddTab("Visual")
local Misc = Win:AddTab("Misc")

Home:AddSection("Actions")

Home:AddButton({
    Text  = "Infinite Jump",
    Style = "primary",
    Callback = function()
        -- your code
    end,
})

Home:AddButton({
    Text  = "Kill All",
    Style = "danger",
    Callback = function()
        -- your code
    end,
})

Home:AddSection("Toggles")

local espToggle = Home:AddToggle({
    Text     = "ESP",
    Default  = false,
    Callback = function(val)
        print("ESP:", val)
    end,
})

Visual:AddSection("Movement")

local speedSlider = Visual:AddSlider({
    Text     = "Walk Speed",
    Min      = 16,
    Max      = 200,
    Default  = 16,
    Callback = function(val)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
    end,
})

Visual:AddDropdown({
    Text    = "Chams style",
    Options = { "Flat", "Wireframe", "Neon", "Rainbow" },
    Default = "Flat",
    Callback = function(val)
        print("Chams:", val)
    end,
})

Misc:AddNotification({ Text = "Library loaded!", Type = "success" })

Misc:AddKeybind({
    Text     = "Toggle Menu",
    Key      = Enum.KeyCode.RightShift,
    Callback = function(key)
        print("New keybind:", key)
    end,
})
]]

return UnknownLib

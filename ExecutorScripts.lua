-- EXECNOXX v2.0 BOS KHOLIK EDITION - REBUILD
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Get Server Start Time from attributes or estimate
local ServerStartTime = Workspace:GetAttribute("ServerStartTime") or tick()
if not Workspace:GetAttribute("ServerStartTime") then
    Workspace:SetAttribute("ServerStartTime", ServerStartTime)
end

local ExecNoxx = {
    Version = "2.0 BOS KHOLIK",
    Prefix = ";",
    Fly = false,
    Noclip = false,
    GodMode = false,
    InfiniteJump = false,
    SpeedWalk = false,
    GravityEnabled = false,
    TPTools = false,
    JPower = false,
    Invisible = false,
    AutoClick = false,
    AutoClickSpeed = 0.1,
    WalkSpeed = 16,
    FlySpeed = 50,
    TPRange = 50,
    JumpPower = 50,
    ShaderActive = {},
    NightMode = false,
    SpectateTarget = nil,
    ServerStartTime = ServerStartTime,
    GUI = {
        Width = 600, 
        Height = 450, 
        LogoSize = 70,
        Locked = false
    }
}

-- RGB Color System
local RGBColor = Color3.fromRGB(255, 0, 0)
local RGBSpeed = 0.00039

spawn(function()
    while true do
        for i = 0, 255 do 
            RGBColor = Color3.fromRGB(255, i, 0) 
            wait(RGBSpeed) 
        end
        for i = 255, 0, -1 do 
            RGBColor = Color3.fromRGB(i, 255, 0) 
            wait(RGBSpeed) 
        end
        for i = 0, 255 do 
            RGBColor = Color3.fromRGB(0, 255, i) 
            wait(RGBSpeed) 
        end
        for i = 255, 0, -1 do 
            RGBColor = Color3.fromRGB(0, i, 255) 
            wait(RGBSpeed) 
        end
        for i = 0, 255 do 
            RGBColor = Color3.fromRGB(i, 0, 255) 
            wait(RGBSpeed) 
        end
        for i = 255, 0, -1 do 
            RGBColor = Color3.fromRGB(255, 0, i) 
            wait(RGBSpeed) 
        end
    end
end)

-- Colors
local Colors = {
    Background = Color3.fromRGB(25, 10, 40),
    Sidebar = Color3.fromRGB(20, 5, 35),
    Header = Color3.fromRGB(30, 15, 50),
    Accent = Color3.fromRGB(147, 112, 219),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(200, 180, 255),
    Button = Color3.fromRGB(35, 20, 55),
    ButtonHover = Color3.fromRGB(45, 30, 70),
    ToggleOn = Color3.fromRGB(147, 112, 219),
    ToggleOff = Color3.fromRGB(50, 35, 70),
    Red = Color3.fromRGB(255, 50, 50),
    Yellow = Color3.fromRGB(255, 200, 50),
    Green = Color3.fromRGB(50, 255, 100)
}

-- Copy Function
local function CopyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    elseif setclipboard then
        setclipboard(text)
    else
        warn("Clipboard not supported")
    end
end

-- Logo GUI (TOP LEFT - Near Chat)
local LogoGui = Instance.new("ScreenGui")
LogoGui.Name = "ExecNoxx_Logo"
LogoGui.Parent = CoreGui
LogoGui.ResetOnSpawn = false
LogoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "LogoFrame"
LogoFrame.Size = UDim2.new(0, ExecNoxx.GUI.LogoSize, 0, ExecNoxx.GUI.LogoSize)
LogoFrame.Position = UDim2.new(0, 10, 0, 10) -- TOP LEFT
LogoFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
LogoFrame.BackgroundTransparency = 0.1
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = LogoGui

-- Rounded corners
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 15)
LogoCorner.Parent = LogoFrame

-- Minimal RGB Border
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoFrame

spawn(function()
    while LogoFrame and LogoFrame.Parent do
        LogoStroke.Color = RGBColor
        wait(0.01)
    end
end)

local LogoText = Instance.new("TextLabel")
LogoText.Name = "LogoText"
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "Ex"
LogoText.TextSize = 28
LogoText.Font = Enum.Font.GothamBlack
LogoText.Parent = LogoFrame

spawn(function()
    while LogoText and LogoText.Parent do
        LogoText.TextColor3 = RGBColor
        wait(0.01)
    end
end)

local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(1, 0, 1, 0)
LogoButton.BackgroundTransparency = 1
LogoButton.Text = ""
LogoButton.Parent = LogoFrame

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExecNoxx_Main"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- RGB Border
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

spawn(function()
    while MainFrame and MainFrame.Parent do
        MainStroke.Color = RGBColor
        wait(0.01)
    end
end)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Colors.Header
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Name = "TopBarFix"
TopBarFix.Size = UDim2.new(1, 0, 0, 20)
TopBarFix.Position = UDim2.new(0, 0, 1, -20)
TopBarFix.BackgroundColor3 = Colors.Header
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, -150, 1, 0)
Watermark.Position = UDim2.new(0, 20, 0, 0)
Watermark.BackgroundTransparency = 1
Watermark.Text = "ExecNoxx v2.0"
Watermark.TextColor3 = Colors.Text
Watermark.TextSize = 22
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.Parent = TopBar

-- Lock Button
local LockBtn = Instance.new("TextButton")
LockBtn.Name = "LockBtn"
LockBtn.Size = UDim2.new(0, 35, 0, 35)
LockBtn.Position = UDim2.new(1, -90, 0, 7)
LockBtn.BackgroundColor3 = Colors.Button
LockBtn.Text = "🔓"
LockBtn.TextColor3 = Colors.Text
LockBtn.TextSize = 18
LockBtn.Font = Enum.Font.GothamBold
LockBtn.Parent = TopBar

local LockCorner = Instance.new("UICorner")
LockCorner.CornerRadius = UDim.new(0, 8)
LockCorner.Parent = LockBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -50, 0, 7)
CloseBtn.BackgroundColor3 = Colors.Accent
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Name = "SidebarFix"
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Colors.Sidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

local TabList = Instance.new("ScrollingFrame")
TabList.Name = "TabList"
TabList.Size = UDim2.new(1, -15, 1, -25)
TabList.Position = UDim2.new(0, 10, 0, 15)
TabList.BackgroundTransparency = 1
TabList.ScrollBarThickness = 2
TabList.ScrollBarImageColor3 = Colors.Accent
TabList.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabList

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -160, 1, -50)
Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundColor3 = Colors.Background
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Size = UDim2.new(1, -25, 1, -25)
Pages.Position = UDim2.new(0, 15, 0, 15)
Pages.BackgroundTransparency = 1
Pages.Parent = Content

-- Toggle GUI
local function ToggleGUI()
    ScreenGui.Enabled = not ScreenGui.Enabled
    if ScreenGui.Enabled then
        LogoFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.2)
        MainFrame.Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
        LogoFrame.Visible = true
    end
end

LogoButton.MouseButton1Click:Connect(ToggleGUI)
CloseBtn.MouseButton1Click:Connect(ToggleGUI)

-- Lock System (FIXED)
LockBtn.MouseButton1Click:Connect(function()
    ExecNoxx.GUI.Locked = not ExecNoxx.GUI.Locked
    if ExecNoxx.GUI.Locked then
        LockBtn.Text = "🔒"
        LockBtn.BackgroundColor3 = Colors.Green
    else
        LockBtn.Text = "🔓"
        LockBtn.BackgroundColor3 = Colors.Button
    end
end)

-- Logo Drag
local LogoDragging = false
local LogoDragStart = nil
local LogoStartPos = nil

LogoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        LogoDragging = true
        LogoDragStart = input.Position
        LogoStartPos = LogoFrame.Position
    end
end)

LogoButton.InputChanged:Connect(function(input)
    if LogoDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - LogoDragStart
        LogoFrame.Position = UDim2.new(
            LogoStartPos.X.Scale, 
            LogoStartPos.X.Offset + delta.X, 
            LogoStartPos.Y.Scale, 
            LogoStartPos.Y.Offset + delta.Y
        )
    end
end)

LogoButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        LogoDragging = false
    end
end)

-- UI Components
local CurrentTab = nil

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name .. "Tab"
    TabBtn.Size = UDim2.new(1, -10, 0, 45)
    TabBtn.Position = UDim2.new(0, 5, 0, 0)
    TabBtn.BackgroundColor3 = Colors.Button
    TabBtn.Text = "  " .. icon .. "  " .. name
    TabBtn.TextColor3 = Colors.Text
    TabBtn.TextSize = 14
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = TabList
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabBtn
    
    local AccentLine = Instance.new("Frame")
    AccentLine.Name = "AccentLine"
    AccentLine.Size = UDim2.new(0, 4, 0.5, 0)
    AccentLine.Position = UDim2.new(0, 8, 0.25, 0)
    AccentLine.BackgroundColor3 = Colors.Accent
    AccentLine.BorderSizePixel = 0
    AccentLine.Parent = TabBtn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 6
    Page.ScrollBarImageColor3 = Colors.Accent
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    Page.Parent = Pages
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.Parent = Page
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
    end)
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Page.Visible = false
            TweenService:Create(CurrentTab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent}):Play()
        CurrentTab = {Button = TabBtn, Page = Page}
    end)
    
    TabBtn.MouseEnter:Connect(function()
        if CurrentTab and CurrentTab.Button ~= TabBtn then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ButtonHover}):Play()
        end
    end)
    
    TabBtn.MouseLeave:Connect(function()
        if CurrentTab and CurrentTab.Button ~= TabBtn then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
        end
    end)
    
    return Page
end

local function CreateToggle(parent, text, default, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Toggle"
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -90, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Colors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Name = "ToggleBg"
    ToggleBg.Size = UDim2.new(0, 50, 0, 26)
    ToggleBg.Position = UDim2.new(1, -65, 0.5, -13)
    ToggleBg.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleBg
    
    local Circle = Instance.new("Frame")
    Circle.Name = "Circle"
    Circle.Size = UDim2.new(0, 22, 0, 22)
    Circle.Position = default and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
    Circle.BackgroundColor3 = Colors.Text
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBg
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local ClickArea = Instance.new("TextButton")
    ClickArea.Name = "ClickArea"
    ClickArea.Size = UDim2.new(1, 0, 1, 0)
    ClickArea.BackgroundTransparency = 1
    ClickArea.Text = ""
    ClickArea.Parent = Container
    
    local Enabled = default
    
    ClickArea.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        callback(Enabled)
        
        if Enabled then
            TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Colors.ToggleOn}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3), {Position = UDim2.new(1, -24, 0.5, -11)}):Play()
        else
            TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Colors.ToggleOff}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -11)}):Play()
        end
    end)
    
    return Container
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Slider"
    Container.Size = UDim2.new(1, -10, 0, 70)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 12, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Colors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Name = "SliderBg"
    SliderBg.Size = UDim2.new(1, -30, 0, 8)
    SliderBg.Position = UDim2.new(0, 15, 0, 40)
    SliderBg.BackgroundColor3 = Colors.ToggleOff
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = Container
    
    local SliderBgCorner = Instance.new("UICorner")
    SliderBgCorner.CornerRadius = UDim.new(1, 0)
    SliderBgCorner.Parent = SliderBg
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    local fillPercent = (default - min) / (max - min)
    SliderFill.Size = UDim2.new(fillPercent, 0, 1, 0)
    SliderFill.BackgroundColor3 = Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local Knob = Instance.new("Frame")
    Knob.Name = "Knob"
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(fillPercent, -10, 0.5, -10)
    Knob.BackgroundColor3 = Colors.Text
    Knob.BorderSizePixel = 0
    Knob.Parent = SliderBg
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local Dragging = false
    
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, -10, 0.5, -10)
        Label.Text = text .. ": " .. value
        callback(value)
    end
    
    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
        end
    end)
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            UpdateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    return Container
end

local function CreateButton(parent, text, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Button"
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Btn = Instance.new("TextButton")
    Btn.Name = "Btn"
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = text
    Btn.TextColor3 = Colors.Text
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Parent = Container
    
    Btn.MouseButton1Click:Connect(callback)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ButtonHover}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
    end)
    
    return Container
end

local function CreateLabel(parent, text, isHeader)
    local Label = Instance.new("TextLabel")
    Label.Name = text .. "Label"
    Label.Size = UDim2.new(1, -10, 0, isHeader and 35 or 25)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = isHeader and Colors.Accent or Colors.TextDark
    Label.TextSize = isHeader and 16 or 12
    Label.Font = isHeader and Enum.Font.GothamBlack or Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    return Label
end

local function CreateCopyRow(parent, labelText, value)
    local Container = Instance.new("Frame")
    Container.Name = labelText .. "Row"
    Container.Size = UDim2.new(1, -10, 0, 40)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText .. ": " .. value:sub(1, 15) .. (string.len(value) > 15 and "..." or "")
    Label.TextColor3 = Colors.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Name = "CopyBtn"
    CopyBtn.Size = UDim2.new(0, 80, 0, 30)
    CopyBtn.Position = UDim2.new(1, -85, 0.5, -15)
    CopyBtn.BackgroundColor3 = Colors.Accent
    CopyBtn.Text = "📋 Copy"
    CopyBtn.TextColor3 = Colors.Text
    CopyBtn.TextSize = 12
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.Parent = Container
    
    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyBtn
    
    CopyBtn.MouseButton1Click:Connect(function()
        CopyToClipboard(value)
        CopyBtn.Text = "✅"
        wait(1)
        CopyBtn.Text = "📋 Copy"
    end)
    
    return Container
end

local function CreateInfoRow(parent, label, value)
    local Container = Instance.new("Frame")
    Container.Name = label .. "Row"
    Container.Size = UDim2.new(1, -10, 0, 30)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    
    local LabelText = Instance.new("TextLabel")
    LabelText.Name = "Label"
    LabelText.Size = UDim2.new(0.4, 0, 1, 0)
    LabelText.BackgroundTransparency = 1
    LabelText.Text = label .. ":"
    LabelText.TextColor3 = Colors.TextDark
    LabelText.TextSize = 13
    LabelText.Font = Enum.Font.GothamSemibold
    LabelText.TextXAlignment = Enum.TextXAlignment.Left
    LabelText.Parent = Container
    
    local ValueText = Instance.new("TextLabel")
    ValueText.Name = "Value"
    ValueText.Size = UDim2.new(0.6, 0, 1, 0)
    ValueText.Position = UDim2.new(0.4, 0, 0, 0)
    ValueText.BackgroundTransparency = 1
    ValueText.Text = value
    ValueText.TextColor3 = Colors.Text
    ValueText.TextSize = 13
    ValueText.Font = Enum.Font.GothamSemibold
    ValueText.TextXAlignment = Enum.TextXAlignment.Left
    ValueText.Parent = Container
    
    return ValueText
end

-- Resize Handle
local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Name = "ResizeHandle"
ResizeHandle.Size = UDim2.new(0, 25, 0, 25)
ResizeHandle.Position = UDim2.new(1, -25, 1, -25)
ResizeHandle.BackgroundColor3 = Colors.Accent
ResizeHandle.Text = "↘"
ResizeHandle.TextColor3 = Colors.Text
ResizeHandle.TextSize = 16
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.ZIndex = 100
ResizeHandle.Parent = MainFrame

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 6)
ResizeCorner.Parent = ResizeHandle

local Resizing = false
local ResizeStart = nil
local StartSize = nil

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Resizing = true
        ResizeStart = input.Position
        StartSize = MainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - ResizeStart
        local newWidth = math.max(400, StartSize.X.Offset + delta.X)
        local newHeight = math.max(300, StartSize.Y.Offset + delta.Y)
        
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        ExecNoxx.GUI.Width = newWidth
        ExecNoxx.GUI.Height = newHeight
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Resizing = false
    end
end)

-- EPIC NIGHT MODE SYSTEM (FORCED & REALISTIC)
local NightObjects = {}
local NightConnections = {}

local function ClearAllNightObjects()
    for _, obj in pairs(NightObjects) do
        pcall(function() obj:Destroy() end)
    end
    NightObjects = {}
    
    for _, conn in pairs(NightConnections) do
        pcall(function() conn:Disconnect() end)
    end
    NightConnections = {}
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 9) == "ExecNight" then
            pcall(function() effect:Destroy() end)
        end
    end
end

local function ResetLighting()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        Lighting.GlobalShadows = true
        Lighting.ClockTime = 14
    end)
end

local function CreateRealisticMoon()
    -- Realistic Moon with phases
    local Moon = Instance.new("Part")
    Moon.Name = "ExecNight_Moon"
    Moon.Shape = Enum.PartType.Ball
    Moon.Size = Vector3.new(200, 200, 200)
    Moon.Position = Vector3.new(0, 1000, -3000)
    Moon.Anchored = true
    Moon.CanCollide = false
    Moon.Material = Enum.Material.Neon
    Moon.Color = Color3.fromRGB(240, 240, 255)
    Moon.Parent = Workspace
    
    -- Moon Glow
    local MoonGlow = Instance.new("PointLight")
    MoonGlow.Name = "MoonGlow"
    MoonGlow.Color = Color3.fromRGB(220, 235, 255)
    MoonGlow.Brightness = 3
    MoonGlow.Range = 8000
    MoonGlow.Parent = Moon
    
    -- Moon Surface Detail (Texture simulation with parts)
    for i = 1, 8 do
        local crater = Instance.new("Part")
        crater.Name = "Crater" .. i
        crater.Shape = Enum.PartType.Ball
        crater.Size = Vector3.new(math.random(20, 40), math.random(10, 20), math.random(20, 40))
        crater.Anchored = true
        crater.CanCollide = false
        crater.Material = Enum.Material.Rock
        crater.Color = Color3.fromRGB(200, 200, 220)
        crater.Transparency = 0.3
        crater.Parent = Moon
        
        local offset = Vector3.new(
            math.random(-80, 80),
            math.random(-30, 30),
            math.random(-80, 80)
        )
        crater.Position = Moon.Position + offset
        table.insert(NightObjects, crater)
    end
    
    table.insert(NightObjects, Moon)
    
    -- Moon Orbit Animation
    local moonConn = RunService.Heartbeat:Connect(function()
        if Moon and Moon.Parent then
            local time = tick() * 0.1
            Moon.Position = Vector3.new(
                math.sin(time) * 3000,
                1000 + math.sin(time * 0.5) * 200,
                math.cos(time) * 3000
            )
            for _, child in pairs(Moon:GetChildren()) do
                if child:IsA("BasePart") then
                    child.Position = Moon.Position + (child.Position - Moon.Position)
                end
            end
        end
    end)
    table.insert(NightConnections, moonConn)
end

local function CreateStarsField()
    -- 500 Realistic Stars with twinkling
    for i = 1, 500 do
        local star = Instance.new("Part")
        star.Name = "ExecNight_Star" .. i
        star.Shape = Enum.PartType.Ball
        local size = math.random(2, 6)
        star.Size = Vector3.new(size, size, size)
        
        -- Spherical distribution
        local distance = math.random(4000, 10000)
        local theta = math.random() * 2 * math.pi
        local phi = math.acos(2 * math.random() - 1)
        
        star.Position = Vector3.new(
            distance * math.sin(phi) * math.cos(theta),
            distance * math.sin(phi) * math.sin(theta),
            distance * math.cos(phi)
        )
        
        star.Anchored = true
        star.CanCollide = false
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, math.random(200, 255))
        star.Parent = Workspace
        
        -- Twinkle effect
        spawn(function()
            while star and star.Parent and ExecNoxx.NightMode do
                star.Transparency = math.random(0, 0.6)
                star.Size = Vector3.new(size * math.random(0.8, 1.2), size * math.random(0.8, 1.2), size * math.random(0.8, 1.2))
                wait(math.random(1, 10) / 10)
            end
        end)
        
        table.insert(NightObjects, star)
    end
    
    -- Shooting Stars
    spawn(function()
        while ExecNoxx.NightMode do
            wait(math.random(3, 8))
            if not ExecNoxx.NightMode then break end
            
            local shootingStar = Instance.new("Part")
            shootingStar.Name = "ShootingStar"
            shootingStar.Shape = Enum.PartType.Ball
            shootingStar.Size = Vector3.new(4, 4, 20)
            shootingStar.Anchored = true
            shootingStar.CanCollide = false
            shootingStar.Material = Enum.Material.Neon
            shootingStar.Color = Color3.fromRGB(255, 255, 200)
            
            local startPos = Vector3.new(
                math.random(-3000, 3000),
                math.random(800, 1500),
                math.random(-3000, 3000)
            )
            local endPos = startPos + Vector3.new(math.random(-1000, 1000), -math.random(500, 800), math.random(-1000, 1000))
            
            shootingStar.CFrame = CFrame.new(startPos, endPos)
            shootingStar.Parent = Workspace
            
            -- Trail
            local trail = Instance.new("Trail")
            trail.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200), Color3.fromRGB(255, 255, 255))
            trail.WidthScale = NumberSequence.new(1, 0)
            trail.Lifetime = 0.5
            trail.Parent = shootingStar
            
            local attachment0 = Instance.new("Attachment")
            attachment0.Position = Vector3.new(0, 0, 10)
            attachment0.Parent = shootingStar
            
            local attachment1 = Instance.new("Attachment")
            attachment1.Position = Vector3.new(0, 0, -10)
            attachment1.Parent = shootingStar
            
            trail.Attachment0 = attachment0
            trail.Attachment1 = attachment1
            
            -- Animate
            local duration = 0.8
            local startTime = tick()
            while tick() - startTime < duration and ExecNoxx.NightMode do
                local alpha = (tick() - startTime) / duration
                shootingStar.Position = startPos:Lerp(endPos, alpha)
                wait()
            end
            
            shootingStar:Destroy()
        end
    end)
end

local function CreatePlanets()
    local planets = {
        {name = "Mars", color = Color3.fromRGB(255, 80, 40), size = 100, distance = 2500, speed = 0.02, hasRings = false},
        {name = "Jupiter", color = Color3.fromRGB(220, 180, 120), size = 300, distance = 4000, speed = 0.015, hasRings = false},
        {name = "Saturn", color = Color3.fromRGB(230, 200, 150), size = 250, distance = 5500, speed = 0.01, hasRings = true},
        {name = "Uranus", color = Color3.fromRGB(100, 200, 255), size = 180, distance = 7000, speed = 0.008, hasRings = false},
        {name = "Neptune", color = Color3.fromRGB(50, 100, 255), size = 170, distance = 8500, speed = 0.006, hasRings = false}
    }
    
    for _, planetData in pairs(planets) do
        local planet = Instance.new("Part")
        planet.Name = "ExecNight_" .. planetData.name
        planet.Shape = Enum.PartType.Ball
        planet.Size = Vector3.new(planetData.size, planetData.size, planetData.size)
        planet.Anchored = true
        planet.CanCollide = false
        planet.Material = Enum.Material.Neon
        planet.Color = planetData.color
        planet.Parent = Workspace
        
        -- Planet glow
        local glow = Instance.new("PointLight")
        glow.Color = planetData.color
        glow.Brightness = 1
        glow.Range = planetData.size * 3
        glow.Parent = planet
        
        -- Saturn Rings
        if planetData.hasRings then
            local ring = Instance.new("Part")
            ring.Name = "Ring"
            ring.Shape = Enum.PartType.Cylinder
            ring.Size = Vector3.new(10, planetData.size * 1.8, planetData.size * 1.8)
            ring.Anchored = true
            ring.CanCollide = false
            ring.Material = Enum.Material.Neon
            ring.Color = Color3.fromRGB(200, 180, 140)
            ring.Transparency = 0.7
            ring.Parent = planet
        end
        
        local angle = math.random(0, 360)
        local conn = RunService.Heartbeat:Connect(function()
            if planet and planet.Parent and ExecNoxx.NightMode then
                angle = angle + planetData.speed
                local rad = math.rad(angle)
                planet.Position = Vector3.new(
                    math.cos(rad) * planetData.distance,
                    600 + math.sin(rad * 0.3) * 300,
                    math.sin(rad) * planetData.distance
                )
                planet.Rotation = Vector3.new(angle * 0.5, angle * 0.3, 0)
            end
        end)
        table.insert(NightConnections, conn)
        table.insert(NightObjects, planet)
    end
end

local function CreateAsteroidBelt()
    for i = 1, 100 do
        local asteroid = Instance.new("Part")
        asteroid.Name = "ExecNight_Asteroid" .. i
        asteroid.Shape = Enum.PartType.Ball
        local size = math.random(8, 25)
        asteroid.Size = Vector3.new(size, size, size)
        asteroid.Anchored = true
        asteroid.CanCollide = false
        asteroid.Material = Enum.Material.Rock
        asteroid.Color = Color3.fromRGB(80, 80, 80)
        asteroid.Parent = Workspace
        
        local distance = math.random(1800, 3200)
        local speed = math.random(1, 4) / 100
        local angle = math.random(0, 360)
        local height = math.random(400, 900)
        local yOffset = math.random(-100, 100)
        
        local conn = RunService.Heartbeat:Connect(function()
            if asteroid and asteroid.Parent and ExecNoxx.NightMode then
                angle = angle + speed
                local rad = math.rad(angle)
                asteroid.Position = Vector3.new(
                    math.cos(rad) * distance,
                    height + yOffset + math.sin(rad * 2) * 50,
                    math.sin(rad) * distance
                )
                asteroid.Rotation = Vector3.new(angle * 3, angle * 2, angle * 4)
            end
        end)
        table.insert(NightConnections, conn)
        table.insert(NightObjects, asteroid)
    end
end

local function CreateAuroraBorealis()
    -- Multiple aurora layers
    for layer = 1, 3 do
        for i = 1, 8 do
            local aurora = Instance.new("Part")
            aurora.Name = "ExecNight_Aurora" .. layer .. "_" .. i
            aurora.Size = Vector3.new(4000, 80, 40)
            aurora.Anchored = true
            aurora.CanCollide = false
            aurora.Material = Enum.Material.Neon
            aurora.Transparency = 0.7
            aurora.Parent = Workspace
            
            local colors = {
                Color3.fromRGB(0, 255, 120),
                Color3.fromRGB(0, 200, 255),
                Color3.fromRGB(100, 0, 255),
                Color3.fromRGB(255, 0, 200),
                Color3.fromRGB(255, 100, 0)
            }
            
            local baseHeight = 600 + layer * 100
            local offset = i * 500
            
            spawn(function()
                local colorIndex = 1
                local time = 0
                while ExecNoxx.NightMode and aurora.Parent do
                    time = time + 0.02
                    aurora.Color = colors[colorIndex]
                    colorIndex = colorIndex + 1
                    if colorIndex > #colors then colorIndex = 1 end
                    
                    -- Wave motion
                    aurora.Position = Vector3.new(
                        math.sin(time + layer) * 800 + offset - 2000,
                        baseHeight + math.sin(time * 2 + i) * 50,
                        -2500 + math.cos(time * 0.5) * 200
                    )
                    aurora.Rotation = Vector3.new(0, math.sin(time) * 10, 0)
                    
                    wait(0.1)
                end
            end)
            
            table.insert(NightObjects, aurora)
        end
    end
end

local function CreateClouds()
    -- Night clouds with subtle glow
    for i = 1, 30 do
        local cloud = Instance.new("Part")
        cloud.Name = "ExecNight_Cloud" .. i
        cloud.Size = Vector3.new(math.random(200, 500), 30, math.random(200, 400))
        cloud.Anchored = true
        cloud.CanCollide = false
        cloud.Material = Enum.Material.SmoothPlastic
        cloud.Color = Color3.fromRGB(40, 40, 60)
        cloud.Transparency = 0.8
        cloud.Parent = Workspace
        
        local startX = math.random(-5000, 5000)
        local startZ = math.random(-5000, 5000)
        local height = math.random(300, 600)
        local speed = math.random(5, 15)
        
        spawn(function()
            local x = startX
            while ExecNoxx.NightMode and cloud.Parent do
                x = x + speed
                if x > 5000 then x = -5000 end
                cloud.Position = Vector3.new(x, height, startZ)
                wait(0.1)
            end
        end)
        
        table.insert(NightObjects, cloud)
    end
end

local function CreateFireflies()
    -- Fireflies/particles near ground
    for i = 1, 200 do
        local firefly = Instance.new("Part")
        firefly.Name = "ExecNight_Firefly" .. i
        firefly.Shape = Enum.PartType.Ball
        firefly.Size = Vector3.new(2, 2, 2)
        firefly.Anchored = true
        firefly.CanCollide = false
        firefly.Material = Enum.Material.Neon
        firefly.Color = Color3.fromRGB(200, 255, 100)
        firefly.Parent = Workspace
        
        local basePos = Vector3.new(
            math.random(-1000, 1000),
            math.random(10, 100),
            math.random(-1000, 1000)
        )
        
        spawn(function()
            while ExecNoxx.NightMode and firefly.Parent do
                local offset = Vector3.new(
                    math.sin(tick() * math.random() * 2) * 20,
                    math.sin(tick() * 3) * 10,
                    math.cos(tick() * math.random() * 2) * 20
                )
                firefly.Position = basePos + offset
                firefly.Transparency = math.random(0, 0.5)
                wait(0.05)
            end
        end)
        
        table.insert(NightObjects, firefly)
    end
end

local function ApplyEpicNightMode()
    ExecNoxx.NightMode = true
    
    -- Force dark lighting (slightly dark only)
    pcall(function()
        Lighting.Brightness = 0.5  -- Slightly dark
        Lighting.Ambient = Color3.fromRGB(60, 60, 80)
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 70)
        Lighting.GlobalShadows = true
        Lighting.ClockTime = 0  -- Midnight
        
        -- Color correction for night atmosphere
        local CC = Instance.new("ColorCorrectionEffect")
        CC.Name = "ExecNight_CC"
        CC.TintColor = Color3.fromRGB(120, 140, 255)  -- Blue night tint
        CC.Saturation = 0.2
        CC.Contrast = 0.1
        CC.Brightness = -0.1  -- Slightly dark
        CC.Parent = Lighting
        
        -- Bloom for glowing objects
        local Bloom = Instance.new("BloomEffect")
        Bloom.Name = "ExecNight_Bloom"
        Bloom.Intensity = 1.2
        Bloom.Size = 56
        Bloom.Threshold = 0.3
        Bloom.Parent = Lighting
        
        -- Blur for depth
        local Blur = Instance.new("BlurEffect")
        Blur.Name = "ExecNight_Blur"
        Blur.Size = 2
        Blur.Parent = Lighting
        
        -- Atmosphere
        local Atmosphere = Instance.new("Atmosphere")
        Atmosphere.Name = "ExecNight_Atmosphere"
        Atmosphere.Density = 0.4
        Atmosphere.Offset = 0.2
        Atmosphere.Color = Color3.fromRGB(80, 90, 120)
        Atmosphere.Decay = Color3.fromRGB(40, 45, 60)
        Atmosphere.Glare = 0.3
        Atmosphere.Haze = 0.5
        Atmosphere.Parent = Lighting
    end)
    
    -- Create all objects
    CreateRealisticMoon()
    CreateStarsField()
    CreatePlanets()
    CreateAsteroidBelt()
    CreateAuroraBorealis()
    CreateClouds()
    CreateFireflies()
end

local function DisableEpicNightMode()
    ExecNoxx.NightMode = false
    ClearAllNightObjects()
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 9) == "ExecNight" then
            pcall(function() effect:Destroy() end)
        end
    end
    
    ResetLighting()
end

-- TP System
local function SmoothTP(targetPos, speed)
    local startPos = HumanoidRootPart.Position
    local distance = (targetPos - startPos).Magnitude
    local duration = distance / speed
    local startTime = tick()
    
    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        HumanoidRootPart.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        wait()
    end
    HumanoidRootPart.CFrame = CFrame.new(targetPos)
end

-- Create Tabs (NO ExecNoxx Tab, NO Sinematik Tab)
local ToolsPage = CreateTab("Tools", "🛠️")
local ShaderPage = CreateTab("Shader", "🎨")
local InfoPage = CreateTab("Info", "📊")

-- TOOLS TAB (NEW LAYOUT)
CreateLabel(ToolsPage, "SHARELOK TAK PARANI", true)

-- Player List Container
local PlayerListContainer = Instance.new("Frame")
PlayerListContainer.Name = "PlayerListContainer"
PlayerListContainer.Size = UDim2.new(1, -10, 0, 200)
PlayerListContainer.BackgroundColor3 = Colors.Button
PlayerListContainer.BorderSizePixel = 0
PlayerListContainer.Parent = ToolsPage

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 10)
ContainerCorner.Parent = PlayerListContainer

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Name = "PlayerListScroll"
PlayerListScroll.Size = UDim2.new(1, -20, 1, -50)
PlayerListScroll.Position = UDim2.new(0, 10, 0, 10)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 4
PlayerListScroll.ScrollBarImageColor3 = Colors.Accent
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
PlayerListScroll.Parent = PlayerListContainer

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayerListScroll

local SelectedPlayer = nil
local PlayerButtons = {}

local function UpdatePlayerList()
    for _, btn in pairs(PlayerButtons) do
        btn:Destroy()
    end
    PlayerButtons = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerBtn = Instance.new("TextButton")
            PlayerBtn.Name = player.Name .. "Btn"
            PlayerBtn.Size = UDim2.new(1, 0, 0, 35)
            PlayerBtn.BackgroundColor3 = Colors.Sidebar
            PlayerBtn.Text = player.DisplayName .. " (@" .. player.Name .. ")"
            PlayerBtn.TextColor3 = Colors.Text
            PlayerBtn.TextSize = 12
            PlayerBtn.Font = Enum.Font.GothamSemibold
            PlayerBtn.Parent = PlayerListScroll
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = PlayerBtn
            
            PlayerBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = player
                for _, btn in pairs(PlayerButtons) do
                    btn.BackgroundColor3 = Colors.Sidebar
                end
                PlayerBtn.BackgroundColor3 = Colors.Accent
            end)
            
            table.insert(PlayerButtons, PlayerBtn)
        end
    end
    
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, #PlayerButtons * 40)
end

local ResetBtn = Instance.new("TextButton")
ResetBtn.Name = "ResetBtn"
ResetBtn.Size = UDim2.new(1, -20, 0, 30)
ResetBtn.Position = UDim2.new(0, 10, 1, -40)
ResetBtn.BackgroundColor3 = Colors.Accent
ResetBtn.Text = "🔄 Reset / Refresh Players"
ResetBtn.TextColor3 = Colors.Text
ResetBtn.TextSize = 12
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.Parent = PlayerListContainer

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 6)
ResetCorner.Parent = ResetBtn

ResetBtn.MouseButton1Click:Connect(UpdatePlayerList)

UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

CreateButton(ToolsPage, "📍 TP to Selected Player", function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SmoothTP(SelectedPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0), ExecNoxx.TPRange)
    end
end)

CreateButton(ToolsPage, "👁️ Spectate Selected Player", function()
    if SelectedPlayer and SelectedPlayer.Character then
        ExecNoxx.SpectateTarget = SelectedPlayer
        Workspace.CurrentCamera.CameraSubject = SelectedPlayer.Character:FindFirstChild("Humanoid") or SelectedPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    end
end)

CreateButton(ToolsPage, "🛑 Stop Spectating", function()
    ExecNoxx.SpectateTarget = nil
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            Workspace.CurrentCamera.CameraSubject = hum
        end
    end
end)

CreateLabel(ToolsPage, "TELEPORT TOOLS", true)

CreateToggle(ToolsPage, "TPTools", false, function(val)
    ExecNoxx.TPTools = val
    if val then
        spawn(function()
            while ExecNoxx.TPTools do
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                        local dist = (obj.Handle.Position - HumanoidRootPart.Position).Magnitude
                        if dist < 50 then
                            pcall(function()
                                obj.Handle.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                            end)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end)

CreateButton(ToolsPage, "🔧 TP to Closest Tool", function()
    local closestTool = nil
    local closestDist = math.huge
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            local dist = (obj.Handle.Position - HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestTool = obj
            end
        end
    end
    
    if closestTool then
        SmoothTP(closestTool.Handle.Position + Vector3.new(0, 3, 0), ExecNoxx.TPRange)
    end
end)

CreateLabel(ToolsPage, "MOVEMENT", true)

CreateToggle(ToolsPage, "Speed Walk", false, function(val)
    ExecNoxx.SpeedWalk = val
    if val then
        spawn(function()
            while ExecNoxx.SpeedWalk do
                if Humanoid then
                    Humanoid.WalkSpeed = ExecNoxx.WalkSpeed
                end
                wait(0.1)
            end
        end)
    else
        if Humanoid then
            Humanoid.WalkSpeed = 16
        end
    end
end)

CreateSlider(ToolsPage, "Walk Speed", 16, 1000, 16, function(val) 
    ExecNoxx.WalkSpeed = val
    if ExecNoxx.SpeedWalk and Humanoid then
        Humanoid.WalkSpeed = val
    end
end)

CreateToggle(ToolsPage, "JPower", false, function(val)
    ExecNoxx.JPower = val
    if val and Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = ExecNoxx.JumpPower
    elseif Humanoid then
        Humanoid.JumpPower = 50
    end
end)

CreateSlider(ToolsPage, "Jump Power", 50, 1000, 50, function(val)
    ExecNoxx.JumpPower = val
    if ExecNoxx.JPower and Humanoid then
        Humanoid.JumpPower = val
    end
end)

CreateToggle(ToolsPage, "Gravity Control", false, function(val)
    ExecNoxx.GravityEnabled = val
    if val then
        Workspace.Gravity = 196
    end
end)

CreateSlider(ToolsPage, "Gravity", 1, 1000, 196, function(val) 
    if ExecNoxx.GravityEnabled then
        Workspace.Gravity = val
    end
end)

CreateToggle(ToolsPage, "INF JUMP", false, function(val)
    ExecNoxx.InfiniteJump = val
end)

UserInputService.JumpRequest:Connect(function()
    if ExecNoxx.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CreateToggle(ToolsPage, "Fly", false, function(val)
    ExecNoxx.Fly = val
    if val then
        local BG = Instance.new("BodyGyro")
        local BV = Instance.new("BodyVelocity")
        BG.P = 9e4; BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9); BG.CFrame = HumanoidRootPart.CFrame
        BV.Velocity = Vector3.new(0, 0, 0); BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BG.Parent = HumanoidRootPart; BV.Parent = HumanoidRootPart
        spawn(function()
            while ExecNoxx.Fly do
                local cam = Workspace.CurrentCamera
                local md = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then md = md + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then md = md - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then md = md - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then md = md + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then md = md + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then md = md - Vector3.new(0, 1, 0) end
                BV.Velocity = md * ExecNoxx.FlySpeed; BG.CFrame = cam.CFrame
                wait()
            end
            BG:Destroy(); BV:Destroy()
        end)
    end
end)

CreateSlider(ToolsPage, "Fly Speed", 10, 200, 50, function(val) ExecNoxx.FlySpeed = val end)

CreateToggle(ToolsPage, "Noclip", false, function(val)
    ExecNoxx.Noclip = val
    if val then
        spawn(function()
            while ExecNoxx.Noclip do
                if Character then 
                    for _, p in pairs(Character:GetDescendants()) do 
                        if p:IsA("BasePart") then 
                            p.CanCollide = false 
                        end 
                    end 
                end
                wait()
            end
            if Character then 
                for _, p in pairs(Character:GetDescendants()) do 
                    if p:IsA("BasePart") then 
                        p.CanCollide = true 
                    end 
                end 
            end
        end)
    end
end)

CreateLabel(ToolsPage, "SPECIAL FEATURES", true)

CreateToggle(ToolsPage, "Invis", false, function(val)
    ExecNoxx.Invisible = val
    if val and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    elseif Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0
            end
        end
    end
end)

CreateToggle(ToolsPage, "God Mode", false, function(val)
    ExecNoxx.GodMode = val
    if val then
        spawn(function()
            while ExecNoxx.GodMode do
                if Humanoid then
                    Humanoid.MaxHealth = math.huge
                    Humanoid.Health = math.huge
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                end
                wait(0.1)
            end
            if Humanoid then
                Humanoid.MaxHealth = 100
                Humanoid.Health = 100
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            end
        end)
    end
end)

CreateLabel(ToolsPage, "AUTO CLICK", true)

CreateToggle(ToolsPage, "Auto Click", false, function(val)
    ExecNoxx.AutoClick = val
end)

CreateSlider(ToolsPage, "Click Speed (0.1-5s)", 1, 50, 10, function(val)
    ExecNoxx.AutoClickSpeed = val / 10
end)

-- Auto Click System
spawn(function()
    while true do
        if ExecNoxx.AutoClick then
            pcall(function()
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end)
            wait(ExecNoxx.AutoClickSpeed)
        else
            wait(0.1)
        end
    end
end)

-- SHADER TAB (NO 120FPS, NO iPcam)
CreateLabel(ShaderPage, "SMOOTH & HD SHADERS", true)

local function ApplyShader(mode)
    if not ExecNoxx.ShaderActive[mode] then
        ExecNoxx.ShaderActive[mode] = true
    end
    
    local settings = {
        ["SMOOTH"] = {Brightness = 0.15, Ambient = Color3.fromRGB(8, 8, 15), Contrast = 0.02, Saturation = 0.06, Bloom = 0.35},
        ["SOFT"] = {Brightness = -0.3, Ambient = Color3.fromRGB(20, 15, 10), Contrast = 0.02, Saturation = -0.03, Bloom = 0.25, Tint = Color3.fromRGB(255, 250, 240)},
        ["HD"] = {Brightness = 0.4, Ambient = Color3.fromRGB(3, 3, 8), Contrast = 0.06, Saturation = 0.12, Bloom = 0.6},
        ["4K"] = {Brightness = 0.6, Ambient = Color3.fromRGB(2, 2, 5), Contrast = 0.08, Saturation = 0.18, Bloom = 0.9}
    }
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 7) == "ExecHD_" then
            pcall(function() effect:Destroy() end)
        end
    end
    
    local totalBrightness = 2
    local totalAmbient = Color3.fromRGB(127, 127, 127)
    local totalContrast = 0
    local totalSaturation = 0
    local totalBloom = 0
    local hasTint = false
    local tintColor = Color3.fromRGB(255, 255, 255)
    
    for shaderName, isActive in pairs(ExecNoxx.ShaderActive) do
        if isActive and settings[shaderName] then
            local s = settings[shaderName]
            totalBrightness = totalBrightness + s.Brightness
            totalAmbient = Color3.fromRGB(
                math.min(255, totalAmbient.R * 255 + s.Ambient.R),
                math.min(255, totalAmbient.G * 255 + s.Ambient.G),
                math.min(255, totalAmbient.B * 255 + s.Ambient.B)
            )
            totalContrast = totalContrast + s.Contrast
            totalSaturation = totalSaturation + s.Saturation
            totalBloom = totalBloom + s.Bloom
            if s.Tint then
                hasTint = true
                tintColor = Color3.fromRGB(
                    (tintColor.R * 255 + s.Tint.R) / 2,
                    (tintColor.G * 255 + s.Tint.G) / 2,
                    (tintColor.B * 255 + s.Tint.B) / 2
                )
            end
        end
    end
    
    pcall(function()
        Lighting.Brightness = math.max(0.5, math.min(5, totalBrightness))
        Lighting.Ambient = totalAmbient
        Lighting.GlobalShadows = true
        
        local CC = Instance.new("ColorCorrectionEffect")
        CC.Name = "ExecHD_CC"
        CC.Contrast = math.min(0.4, totalContrast)
        CC.Saturation = math.max(-0.3, math.min(0.4, totalSaturation))
        if hasTint then CC.TintColor = tintColor end
        CC.Parent = Lighting
        
        if totalBloom > 0 then
            local Bloom = Instance.new("BloomEffect")
            Bloom.Name = "ExecHD_Bloom"
            Bloom.Intensity = math.min(1.5, totalBloom)
            Bloom.Size = 24
            Bloom.Parent = Lighting
        end
        
        local Blur = Instance.new("BlurEffect")
        Blur.Name = "ExecHD_Blur"
        Blur.Size = 1.5
        Blur.Parent = Lighting
    end)
end

local function RemoveShader(mode)
    ExecNoxx.ShaderActive[mode] = nil
    if next(ExecNoxx.ShaderActive) ~= nil then
        ApplyShader()
    else
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect.Name:sub(1, 7) == "ExecHD_" then
                pcall(function() effect:Destroy() end)
            end
        end
        ResetLighting()
    end
end

CreateToggle(ShaderPage, "SMOOTH", false, function(val) 
    if val then ApplyShader("SMOOTH") else RemoveShader("SMOOTH") end 
end)

CreateToggle(ShaderPage, "SOFT", false, function(val) 
    if val then ApplyShader("SOFT") else RemoveShader("SOFT") end 
end)

CreateToggle(ShaderPage, "HD", false, function(val) 
    if val then ApplyShader("HD") else RemoveShader("HD") end 
end)

CreateToggle(ShaderPage, "4K", false, function(val) 
    if val then ApplyShader("4K") else RemoveShader("4K") end 
end)

CreateLabel(ShaderPage, "SPECIAL MODES", true)

CreateToggle(ShaderPage, "🌙 Night Mode (Epic)", false, function(val)
    if val then ApplyEpicNightMode() else DisableEpicNightMode() end
end)

CreateLabel(ShaderPage, "RESET", true)

CreateButton(ShaderPage, "🗑️ Reset All Shaders", function()
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 7) == "ExecHD_" or effect.Name:sub(1, 9) == "ExecNight" then
            pcall(function() effect:Destroy() end)
        end
    end
    ExecNoxx.ShaderActive = {}
    ExecNoxx.NightMode = false
    ResetLighting()
end)

-- INFO TAB (NEW LAYOUT)
CreateLabel(InfoPage, "SERVER INFORMATION", true)

CreateCopyRow(InfoPage, "Job ID", game.JobId)
CreateCopyRow(InfoPage, "Server ID", game.JobId:sub(1, 8) .. "-" .. game.JobId:sub(9, 12))

CreateLabel(InfoPage, "SERVER HOP", true)

CreateButton(InfoPage, "🔄 Hop Server (1-5 Players)", function()
    local servers = {}
    local req = syn and syn.request or http_request or request
    if req then
        local res = req({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        if res and res.Body then
            local data = HttpService:JSONDecode(res.Body)
            for _, server in pairs(data.data) do
                if server.playing >= 1 and server.playing <= 5 then
                    table.insert(servers, server.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
            end
        end
    end
end)

CreateButton(InfoPage, "🔄 Hop Server (1-3 Players)", function()
    local servers = {}
    local req = syn and syn.request or http_request or request
    if req then
        local res = req({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        if res and res.Body then
            local data = HttpService:JSONDecode(res.Body)
            for _, server in pairs(data.data) do
                if server.playing >= 1 and server.playing <= 3 then
                    table.insert(servers, server.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
            end
        end
    end
end)

-- Info Rows
local PlayersRow = CreateInfoRow(InfoPage, "Players", "Loading...")
local TimeRow = CreateInfoRow(InfoPage, "Game Time", "Loading...")

-- Server Uptime (Real server uptime before player joined)
local UptimeRow = CreateInfoRow(InfoPage, "Server Uptime", "Loading...")

spawn(function()
    while true do
        -- Calculate real server uptime
        local elapsed = tick() - ExecNoxx.ServerStartTime
        local days = math.floor(elapsed / 86400)
        local hours = math.floor((elapsed % 86400) / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)
        
        UptimeRow.Text = string.format("%d Days, %02d Hours, %02d Min, %02d Sec", days, hours, minutes, seconds)
        PlayersRow.Text = #Players:GetPlayers() .. "/" .. Players.MaxPlayers
        TimeRow.Text = math.floor(Lighting.ClockTime) .. ":00"
        
        wait(1)
    end
end)

-- Ping with Signal Bars
local PingContainer = Instance.new("Frame")
PingContainer.Name = "PingContainer"
PingContainer.Size = UDim2.new(1, -10, 0, 40)
PingContainer.BackgroundTransparency = 1
PingContainer.Parent = InfoPage

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "PingLabel"
PingLabel.Size = UDim2.new(0.4, 0, 1, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Ping:"
PingLabel.TextColor3 = Colors.TextDark
PingLabel.TextSize = 13
PingLabel.Font = Enum.Font.GothamSemibold
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Parent = PingContainer

local PingValue = Instance.new("TextLabel")
PingValue.Name = "PingValue"
PingValue.Size = UDim2.new(0.2, 0, 1, 0)
PingValue.Position = UDim2.new(0.4, 0, 0, 0)
PingValue.BackgroundTransparency = 1
PingValue.Text = "Loading..."
PingValue.TextColor3 = Colors.Text
PingValue.TextSize = 13
PingValue.Font = Enum.Font.GothamSemibold
PingValue.TextXAlignment = Enum.TextXAlignment.Left
PingValue.Parent = PingContainer

-- Signal Bars
local SignalFrame = Instance.new("Frame")
SignalFrame.Name = "SignalFrame"
SignalFrame.Size = UDim2.new(0, 50, 0, 30)
SignalFrame.Position = UDim2.new(1, -60, 0.5, -15)
SignalFrame.BackgroundTransparency = 1
SignalFrame.Parent = PingContainer

local bars = {}
for i = 1, 4 do
    local bar = Instance.new("Frame")
    bar.Name = "Bar" .. i
    bar.Size = UDim2.new(0, 8, 0, i * 6)
    bar.Position = UDim2.new(0, (i-1) * 12, 1, -i * 6)
    bar.BackgroundColor3 = Colors.Green
    bar.BorderSizePixel = 0
    bar.Parent = SignalFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Parent = bar
    
    table.insert(bars, bar)
end

spawn(function()
    while true do
        local ping = Stats.PerformanceStats.Ping:GetValue()
        PingValue.Text = math.floor(ping) .. " ms"
        
        local signalColor = Colors.Green
        local activeBars = 4
        if ping > 300 then
            signalColor = Colors.Red
            activeBars = 1
        elseif ping > 150 then
            signalColor = Colors.Yellow
            activeBars = 2
        elseif ping > 80 then
            signalColor = Colors.Yellow
            activeBars = 3
        end
        
        for i, bar in pairs(bars) do
            if i <= activeBars then
                bar.BackgroundColor3 = signalColor
                bar.BackgroundTransparency = 0
            else
                bar.BackgroundTransparency = 0.7
            end
        end
        
        wait(1)
    end
end)

CreateLabel(InfoPage, "LOCAL PLAYER INFO", true)

local NameRow = CreateInfoRow(InfoPage, "Name", LocalPlayer.Name)
local DisplayRow = CreateInfoRow(InfoPage, "Display", LocalPlayer.DisplayName)
local UserIdRow = CreateInfoRow(InfoPage, "UserId", tostring(LocalPlayer.UserId))

-- Account Age Feature
local AccountAgeRow = CreateInfoRow(InfoPage, "Account Age", "Loading...")

spawn(function()
    while true do
        local age = LocalPlayer.AccountAge
        local years = math.floor(age / 365)
        local months = math.floor((age % 365) / 30)
        local days = age % 30
        
        local ageText = ""
        if years > 0 then
            ageText = years .. " years, " .. months .. " months, " .. days .. " days"
        elseif months > 0 then
            ageText = months .. " months, " .. days .. " days"
        else
            ageText = days .. " days"
        end
        
        AccountAgeRow.Text = ageText
        wait(60) -- Update every minute
    end
end)

-- Select first tab
wait(0.1)
for _, child in pairs(TabList:GetChildren()) do
    if child:IsA("TextButton") then
        child.MouseButton1Click:Fire()
        break
    end
end

-- Drag Main GUI (FIXED LOCK SYSTEM)
local Dragging = false
local DragInput = nil
local DragStart = nil
local StartPos = nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        DragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
        if not ExecNoxx.GUI.Locked then  -- Only drag if not locked
            local delta = input.Position - DragStart
            MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

print("=== EXECNOXX v2.0 BOS KHOLIK EDITION LOADED ===")
print("Removed: Intro, Sinematik Tab, 120FPS, iPcam")
print("Added: Epic Night Mode, Account Age, Fixed Server Uptime")
print("UI: Logo Top Left, Fixed Lock System")
            RGBColor = Color3.fromRGB(255, 0, i) 
            wait(RGBSpeed) 
        end
    end
end)

-- Colors
local Colors = {
    Background = Color3.fromRGB(25, 10, 40),
    Sidebar = Color3.fromRGB(20, 5, 35),
    Header = Color3.fromRGB(30, 15, 50),
    Accent = Color3.fromRGB(147, 112, 219),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(200, 180, 255),
    Button = Color3.fromRGB(35, 20, 55),
    ButtonHover = Color3.fromRGB(45, 30, 70),
    ToggleOn = Color3.fromRGB(147, 112, 219),
    ToggleOff = Color3.fromRGB(50, 35, 70),
    Red = Color3.fromRGB(255, 50, 50),
    Yellow = Color3.fromRGB(255, 200, 50),
    Green = Color3.fromRGB(50, 255, 100)
}

-- Copy Function
local function CopyToClipboard(text)
    if syn then
        syn.write_clipboard(text)
    elseif setclipboard then
        setclipboard(text)
    else
        warn("Clipboard not supported")
    end
end

-- INTRO SYSTEM
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "ExecNoxx_Intro"
IntroGui.Parent = CoreGui
IntroGui.ResetOnSpawn = false
IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(0, 0, 0, 300)
IntroFrame.Position = UDim2.new(0.5, 0, 0.5, -150)
IntroFrame.BackgroundTransparency = 1
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = IntroGui

local IntroText = Instance.new("TextLabel")
IntroText.Name = "IntroText"
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = [[
     ███████╗██╗  ██╗███████╗ ██████╗██╗  ██╗ ██████╗ ██╗  ██╗██╗  ██╗
     ██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║  ██║██╔═══██╗╚██╗██╔╝╚██╗██╔╝
     █████╗   ╚███╔╝ █████╗  ██║     ███████║██║   ██║ ╚███╔╝  ╚███╔╝ 
     ██╔══╝   ██╔██╗ ██╔══╝  ██║     ██╔══██║██║   ██║ ██╔██╗  ██╔██╗ 
     ███████╗██╔╝ ██╗███████╗╚██████╗██║  ██║╚██████╔╝██╔╝ ██╗██╔╝ ██╗
     ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                           BOS KHOLIK EDITION]]
IntroText.TextColor3 = RGBColor
IntroText.TextSize = 14
IntroText.Font = Enum.Font.Code
IntroText.TextWrapped = true
IntroText.Parent = IntroFrame

-- RGB Intro Text
spawn(function()
    while IntroText and IntroText.Parent do
        IntroText.TextColor3 = RGBColor
        wait(0.01)
    end
end)

-- Intro Animation (Expand from center for 5 seconds)
TweenService:Create(IntroFrame, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 800, 0, 300),
    Position = UDim2.new(0.5, -400, 0.5, -150)
}):Play()

-- Wait 5 seconds expanding + 2 seconds hold = 7 seconds total
wait(7)

-- Fade out intro
TweenService:Create(IntroText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
wait(0.5)
IntroGui:Destroy()

-- Logo GUI (Top Right Near Chat)
local LogoGui = Instance.new("ScreenGui")
LogoGui.Name = "ExecNoxx_Logo"
LogoGui.Parent = CoreGui
LogoGui.ResetOnSpawn = false
LogoGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "LogoFrame"
LogoFrame.Size = UDim2.new(0, ExecNoxx.GUI.LogoSize, 0, ExecNoxx.GUI.LogoSize)
LogoFrame.Position = UDim2.new(1, -90, 0, 10)
LogoFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 35)
LogoFrame.BackgroundTransparency = 0.1
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = LogoGui

-- Rounded corners
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 15)
LogoCorner.Parent = LogoFrame

-- Minimal RGB Border
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoFrame

spawn(function()
    while LogoFrame and LogoFrame.Parent do
        LogoStroke.Color = RGBColor
        wait(0.01)
    end
end)

local LogoText = Instance.new("TextLabel")
LogoText.Name = "LogoText"
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "Ex"
LogoText.TextSize = 28
LogoText.Font = Enum.Font.GothamBlack
LogoText.Parent = LogoFrame

spawn(function()
    while LogoText and LogoText.Parent do
        LogoText.TextColor3 = RGBColor
        wait(0.01)
    end
end)

local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(1, 0, 1, 0)
LogoButton.BackgroundTransparency = 1
LogoButton.Text = ""
LogoButton.Parent = LogoFrame

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExecNoxx_Main"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- RGB Border
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

spawn(function()
    while MainFrame and MainFrame.Parent do
        MainStroke.Color = RGBColor
        wait(0.01)
    end
end)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Colors.Header
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Name = "TopBarFix"
TopBarFix.Size = UDim2.new(1, 0, 0, 20)
TopBarFix.Position = UDim2.new(0, 0, 1, -20)
TopBarFix.BackgroundColor3 = Colors.Header
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, -150, 1, 0)
Watermark.Position = UDim2.new(0, 20, 0, 0)
Watermark.BackgroundTransparency = 1
Watermark.Text = "ExecNoxx v1.0"
Watermark.TextColor3 = Colors.Text
Watermark.TextSize = 22
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.Parent = TopBar

-- Lock Button
local LockBtn = Instance.new("TextButton")
LockBtn.Name = "LockBtn"
LockBtn.Size = UDim2.new(0, 35, 0, 35)
LockBtn.Position = UDim2.new(1, -90, 0, 7)
LockBtn.BackgroundColor3 = Colors.Button
LockBtn.Text = "🔓"
LockBtn.TextColor3 = Colors.Text
LockBtn.TextSize = 18
LockBtn.Font = Enum.Font.GothamBold
LockBtn.Parent = TopBar

local LockCorner = Instance.new("UICorner")
LockCorner.CornerRadius = UDim.new(0, 8)
LockCorner.Parent = LockBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -50, 0, 7)
CloseBtn.BackgroundColor3 = Colors.Accent
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Name = "SidebarFix"
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Colors.Sidebar
SidebarFix.BorderSizePixel = 0
SidebarFix.Parent = Sidebar

local TabList = Instance.new("ScrollingFrame")
TabList.Name = "TabList"
TabList.Size = UDim2.new(1, -15, 1, -25)
TabList.Position = UDim2.new(0, 10, 0, 15)
TabList.BackgroundTransparency = 1
TabList.ScrollBarThickness = 2
TabList.ScrollBarImageColor3 = Colors.Accent
TabList.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabList

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -160, 1, -50)
Content.Position = UDim2.new(0, 160, 0, 50)
Content.BackgroundColor3 = Colors.Background
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Size = UDim2.new(1, -25, 1, -25)
Pages.Position = UDim2.new(0, 15, 0, 15)
Pages.BackgroundTransparency = 1
Pages.Parent = Content

-- Toggle GUI
local function ToggleGUI()
    ScreenGui.Enabled = not ScreenGui.Enabled
    if ScreenGui.Enabled then
        LogoFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.2)
        MainFrame.Size = UDim2.new(0, ExecNoxx.GUI.Width, 0, ExecNoxx.GUI.Height)
        LogoFrame.Visible = true
    end
end

LogoButton.MouseButton1Click:Connect(ToggleGUI)
CloseBtn.MouseButton1Click:Connect(ToggleGUI)

-- Lock System
LockBtn.MouseButton1Click:Connect(function()
    ExecNoxx.GUI.Locked = not ExecNoxx.GUI.Locked
    if ExecNoxx.GUI.Locked then
        LockBtn.Text = "🔒"
        LockBtn.BackgroundColor3 = Colors.Green
    else
        LockBtn.Text = "🔓"
        LockBtn.BackgroundColor3 = Colors.Button
    end
end)

-- Logo Drag
local LogoDragging = false
local LogoDragStart = nil
local LogoStartPos = nil

LogoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        LogoDragging = true
        LogoDragStart = input.Position
        LogoStartPos = LogoFrame.Position
    end
end)

LogoButton.InputChanged:Connect(function(input)
    if LogoDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - LogoDragStart
        LogoFrame.Position = UDim2.new(
            LogoStartPos.X.Scale, 
            LogoStartPos.X.Offset + delta.X, 
            LogoStartPos.Y.Scale, 
            LogoStartPos.Y.Offset + delta.Y
        )
    end
end)

LogoButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        LogoDragging = false
    end
end)

-- UI Components
local CurrentTab = nil

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name .. "Tab"
    TabBtn.Size = UDim2.new(1, -10, 0, 45)
    TabBtn.Position = UDim2.new(0, 5, 0, 0)
    TabBtn.BackgroundColor3 = Colors.Button
    TabBtn.Text = "  " .. icon .. "  " .. name
    TabBtn.TextColor3 = Colors.Text
    TabBtn.TextSize = 14
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = TabList
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabBtn
    
    local AccentLine = Instance.new("Frame")
    AccentLine.Name = "AccentLine"
    AccentLine.Size = UDim2.new(0, 4, 0.5, 0)
    AccentLine.Position = UDim2.new(0, 8, 0.25, 0)
    AccentLine.BackgroundColor3 = Colors.Accent
    AccentLine.BorderSizePixel = 0
    AccentLine.Parent = TabBtn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 6
    Page.ScrollBarImageColor3 = Colors.Accent
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    Page.Parent = Pages
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.Parent = Page
    
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
    end)
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Page.Visible = false
            TweenService:Create(CurrentTab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Accent}):Play()
        CurrentTab = {Button = TabBtn, Page = Page}
    end)
    
    TabBtn.MouseEnter:Connect(function()
        if CurrentTab and CurrentTab.Button ~= TabBtn then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ButtonHover}):Play()
        end
    end)
    
    TabBtn.MouseLeave:Connect(function()
        if CurrentTab and CurrentTab.Button ~= TabBtn then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
        end
    end)
    
    return Page
end

local function CreateToggle(parent, text, default, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Toggle"
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -90, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Colors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Name = "ToggleBg"
    ToggleBg.Size = UDim2.new(0, 50, 0, 26)
    ToggleBg.Position = UDim2.new(1, -65, 0.5, -13)
    ToggleBg.BackgroundColor3 = default and Colors.ToggleOn or Colors.ToggleOff
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleBg
    
    local Circle = Instance.new("Frame")
    Circle.Name = "Circle"
    Circle.Size = UDim2.new(0, 22, 0, 22)
    Circle.Position = default and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
    Circle.BackgroundColor3 = Colors.Text
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBg
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle
    
    local ClickArea = Instance.new("TextButton")
    ClickArea.Name = "ClickArea"
    ClickArea.Size = UDim2.new(1, 0, 1, 0)
    ClickArea.BackgroundTransparency = 1
    ClickArea.Text = ""
    ClickArea.Parent = Container
    
    local Enabled = default
    
    ClickArea.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        callback(Enabled)
        
        if Enabled then
            TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Colors.ToggleOn}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3), {Position = UDim2.new(1, -24, 0.5, -11)}):Play()
        else
            TweenService:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = Colors.ToggleOff}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -11)}):Play()
        end
    end)
    
    return Container
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Slider"
    Container.Size = UDim2.new(1, -10, 0, 70)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 12, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Colors.Text
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Name = "SliderBg"
    SliderBg.Size = UDim2.new(1, -30, 0, 8)
    SliderBg.Position = UDim2.new(0, 15, 0, 40)
    SliderBg.BackgroundColor3 = Colors.ToggleOff
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = Container
    
    local SliderBgCorner = Instance.new("UICorner")
    SliderBgCorner.CornerRadius = UDim.new(1, 0)
    SliderBgCorner.Parent = SliderBg
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "SliderFill"
    local fillPercent = (default - min) / (max - min)
    SliderFill.Size = UDim2.new(fillPercent, 0, 1, 0)
    SliderFill.BackgroundColor3 = Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill
    
    local Knob = Instance.new("Frame")
    Knob.Name = "Knob"
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(fillPercent, -10, 0.5, -10)
    Knob.BackgroundColor3 = Colors.Text
    Knob.BorderSizePixel = 0
    Knob.Parent = SliderBg
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local Dragging = false
    
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, -10, 0.5, -10)
        Label.Text = text .. ": " .. value
        callback(value)
    end
    
    Knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
        end
    end)
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            UpdateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    return Container
end

local function CreateButton(parent, text, callback)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Button"
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Btn = Instance.new("TextButton")
    Btn.Name = "Btn"
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = text
    Btn.TextColor3 = Colors.Text
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Parent = Container
    
    Btn.MouseButton1Click:Connect(callback)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ButtonHover}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Button}):Play()
    end)
    
    return Container
end

local function CreateCopyButton(parent, text, value)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Copy"
    Container.Size = UDim2.new(1, -10, 0, 70)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -20, 0, 35)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = text .. ": " .. value:sub(1, 20) .. (string.len(value) > 20 and "..." or "")
    Label.TextColor3 = Colors.Text
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.Parent = Container
    
    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Name = "CopyBtn"
    CopyBtn.Size = UDim2.new(1, -20, 0, 25)
    CopyBtn.Position = UDim2.new(0, 10, 0, 40)
    CopyBtn.BackgroundColor3 = Colors.Accent
    CopyBtn.Text = "📋 Copy"
    CopyBtn.TextColor3 = Colors.Text
    CopyBtn.TextSize = 12
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.Parent = Container
    
    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyBtn
    
    CopyBtn.MouseButton1Click:Connect(function()
        CopyToClipboard(value)
        CopyBtn.Text = "✅ Copied!"
        wait(1)
        CopyBtn.Text = "📋 Copy"
    end)
    
    return Container
end

local function CreateLabel(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Name = text .. "Label"
    Label.Size = UDim2.new(1, -10, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Colors.TextDark
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    return Label
end

local function CreateInfoLabel(parent, text)
    local Container = Instance.new("Frame")
    Container.Name = text .. "Info"
    Container.Size = UDim2.new(1, -10, 0, 60)
    Container.BackgroundColor3 = Colors.Button
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Colors.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.Parent = Container
    
    return Container, Label
end

-- Resize Handle
local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Name = "ResizeHandle"
ResizeHandle.Size = UDim2.new(0, 25, 0, 25)
ResizeHandle.Position = UDim2.new(1, -25, 1, -25)
ResizeHandle.BackgroundColor3 = Colors.Accent
ResizeHandle.Text = "↘"
ResizeHandle.TextColor3 = Colors.Text
ResizeHandle.TextSize = 16
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.ZIndex = 100
ResizeHandle.Parent = MainFrame

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 6)
ResizeCorner.Parent = ResizeHandle

local Resizing = false
local ResizeStart = nil
local StartSize = nil

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Resizing = true
        ResizeStart = input.Position
        StartSize = MainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - ResizeStart
        local newWidth = math.max(400, StartSize.X.Offset + delta.X)
        local newHeight = math.max(300, StartSize.Y.Offset + delta.Y)
        
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        ExecNoxx.GUI.Width = newWidth
        ExecNoxx.GUI.Height = newHeight
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Resizing = false
    end
end)

-- Shader System
local NightObjects = {}

local function ClearAllShaders()
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 7) == "ExecHD_" or effect.Name:sub(1, 9) == "ExecNight" then
            pcall(function() effect:Destroy() end)
        end
    end
    for _, obj in pairs(NightObjects) do
        pcall(function() obj:Destroy() end)
    end
    NightObjects = {}
    ExecNoxx.ShaderActive = {}
    ExecNoxx.NightMode = false
end

local function ResetLighting()
    pcall(function()
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        Lighting.GlobalShadows = true
        Lighting.ClockTime = 14
    end)
end

-- Smooth 120FPS Shaders
local function ApplyShader(mode)
    if not ExecNoxx.ShaderActive[mode] then
        ExecNoxx.ShaderActive[mode] = true
    end
    
    local totalBrightness = 2
    local totalAmbient = Color3.fromRGB(127, 127, 127)
    local totalContrast = 0
    local totalSaturation = 0
    local totalBloom = 0
    local hasTint = false
    local tintColor = Color3.fromRGB(255, 255, 255)
    
    local settings = {
        ["120FPS"] = {Brightness = 0.2, Ambient = Color3.fromRGB(5, 5, 10), Contrast = 0.03, Saturation = 0.08, Bloom = 0.4},
        ["SMOOTH"] = {Brightness = 0.15, Ambient = Color3.fromRGB(8, 8, 15), Contrast = 0.02, Saturation = 0.06, Bloom = 0.35},
        ["SOFT"] = {Brightness = -0.3, Ambient = Color3.fromRGB(20, 15, 10), Contrast = 0.02, Saturation = -0.03, Bloom = 0.25, Tint = Color3.fromRGB(255, 250, 240)},
        ["HD"] = {Brightness = 0.4, Ambient = Color3.fromRGB(3, 3, 8), Contrast = 0.06, Saturation = 0.12, Bloom = 0.6},
        ["4K"] = {Brightness = 0.6, Ambient = Color3.fromRGB(2, 2, 5), Contrast = 0.08, Saturation = 0.18, Bloom = 0.9},
        ["iPcam"] = {Brightness = 0.3, Ambient = Color3.fromRGB(10, 10, 12), Contrast = 0.05, Saturation = 0.1, Bloom = 0.5, Tint = Color3.fromRGB(255, 255, 250)}
    }
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 7) == "ExecHD_" then
            pcall(function() effect:Destroy() end)
        end
    end
    
    for shaderName, isActive in pairs(ExecNoxx.ShaderActive) do
        if isActive and settings[shaderName] then
            local s = settings[shaderName]
            totalBrightness = totalBrightness + s.Brightness
            totalAmbient = Color3.fromRGB(
                math.min(255, totalAmbient.R * 255 + s.Ambient.R),
                math.min(255, totalAmbient.G * 255 + s.Ambient.G),
                math.min(255, totalAmbient.B * 255 + s.Ambient.B)
            )
            totalContrast = totalContrast + s.Contrast
            totalSaturation = totalSaturation + s.Saturation
            totalBloom = totalBloom + s.Bloom
            if s.Tint then
                hasTint = true
                tintColor = Color3.fromRGB(
                    (tintColor.R * 255 + s.Tint.R) / 2,
                    (tintColor.G * 255 + s.Tint.G) / 2,
                    (tintColor.B * 255 + s.Tint.B) / 2
                )
            end
        end
    end
    
    pcall(function()
        Lighting.Brightness = math.max(0.5, math.min(5, totalBrightness))
        Lighting.Ambient = totalAmbient
        Lighting.GlobalShadows = true
        
        local CC = Instance.new("ColorCorrectionEffect")
        CC.Name = "ExecHD_CC"
        CC.Contrast = math.min(0.4, totalContrast)
        CC.Saturation = math.max(-0.3, math.min(0.4, totalSaturation))
        if hasTint then CC.TintColor = tintColor end
        CC.Parent = Lighting
        
        if totalBloom > 0 then
            local Bloom = Instance.new("BloomEffect")
            Bloom.Name = "ExecHD_Bloom"
            Bloom.Intensity = math.min(1.5, totalBloom)
            Bloom.Size = 24
            Bloom.Parent = Lighting
        end
        
        local Blur = Instance.new("BlurEffect")
        Blur.Name = "ExecHD_Blur"
        Blur.Size = 1.5
        Blur.Parent = Lighting
    end)
end

local function RemoveShader(mode)
    ExecNoxx.ShaderActive[mode] = nil
    if next(ExecNoxx.ShaderActive) ~= nil then
        ApplyShader()
    else
        ClearAllShaders()
        ResetLighting()
    end
end

-- Epic Night Mode
local function ApplyNightMode()
    ExecNoxx.NightMode = true
    
    pcall(function()
        Lighting.Brightness = 0.8
        Lighting.Ambient = Color3.fromRGB(80, 90, 120)
        Lighting.OutdoorAmbient = Color3.fromRGB(70, 80, 110)
        Lighting.GlobalShadows = true
        Lighting.ClockTime = 0
        
        -- Moon
        local Moon = Instance.new("Part")
        Moon.Name = "ExecNight_Moon"
        Moon.Shape = Enum.PartType.Ball
        Moon.Size = Vector3.new(150, 150, 150)
        Moon.Position = Vector3.new(0, 800, -2000)
        Moon.Anchored = true
        Moon.CanCollide = false
        Moon.Material = Enum.Material.Neon
        Moon.Color = Color3.fromRGB(240, 240, 255)
        Moon.Parent = Workspace
        
        local MoonLight = Instance.new("PointLight")
        MoonLight.Color = Color3.fromRGB(220, 235, 255)
        MoonLight.Brightness = 2
        MoonLight.Range = 5000
        MoonLight.Parent = Moon
        
        table.insert(NightObjects, Moon)
        
        -- Planets
        local planets = {
            {name = "Mars", color = Color3.fromRGB(255, 100, 50), size = 80, distance = 1000, speed = 0.05},
            {name = "Jupiter", color = Color3.fromRGB(200, 150, 100), size = 200, distance = 2000, speed = 0.03},
            {name = "Saturn", color = Color3.fromRGB(230, 200, 150), size = 180, distance = 3000, speed = 0.02},
            {name = "Neptune", color = Color3.fromRGB(50, 100, 255), size = 120, distance = 4000, speed = 0.015},
            {name = "Pluto", color = Color3.fromRGB(200, 200, 200), size = 40, distance = 5000, speed = 0.01}
        }
        
        for _, planetData in pairs(planets) do
            local planet = Instance.new("Part")
            planet.Name = "ExecNight_" .. planetData.name
            planet.Shape = Enum.PartType.Ball
            planet.Size = Vector3.new(planetData.size, planetData.size, planetData.size)
            planet.Anchored = true
            planet.CanCollide = false
            planet.Material = Enum.Material.Neon
            planet.Color = planetData.color
            planet.Parent = Workspace
            
            spawn(function()
                local angle = math.random(0, 360)
                while ExecNoxx.NightMode and planet.Parent do
                    angle = angle + planetData.speed
                    local rad = math.rad(angle)
                    planet.Position = Vector3.new(
                        math.cos(rad) * planetData.distance,
                        600 + math.sin(rad * 0.5) * 200,
                        math.sin(rad) * planetData.distance
                    )
                    wait(0.03)
                end
            end)
            
            table.insert(NightObjects, planet)
        end
        
        -- Asteroids
        for i = 1, 30 do
            local asteroid = Instance.new("Part")
            asteroid.Name = "ExecNight_Asteroid" .. i
            asteroid.Shape = Enum.PartType.Ball
            asteroid.Size = Vector3.new(math.random(10, 30), math.random(10, 30), math.random(10, 30))
            asteroid.Anchored = true
            asteroid.CanCollide = false
            asteroid.Material = Enum.Material.Rock
            asteroid.Color = Color3.fromRGB(100, 100, 100)
            asteroid.Parent = Workspace
            
            local distance = math.random(1200, 4500)
            local speed = math.random(1, 5) / 100
            local angle = math.random(0, 360)
            local height = math.random(400, 800)
            
            spawn(function()
                while ExecNoxx.NightMode and asteroid.Parent do
                    angle = angle + speed
                    local rad = math.rad(angle)
                    asteroid.Position = Vector3.new(
                        math.cos(rad) * distance,
                        height + math.sin(rad * 2) * 50,
                        math.sin(rad) * distance
                    )
                    asteroid.Rotation = Vector3.new(angle * 2, angle * 3, angle)
                    wait(0.03)
                end
            end)
            
            table.insert(NightObjects, asteroid)
        end
        
        -- Stars
        for i = 1, 200 do
            local star = Instance.new("Part")
            star.Name = "ExecNight_Star" .. i
            star.Shape = Enum.PartType.Ball
            star.Size = Vector3.new(math.random(2, 8), math.random(2, 8), math.random(2, 8))
            local distance = math.random(3000, 8000)
            local angle1 = math.random(0, 360)
            local angle2 = math.random(-60, 60)
            local rad1 = math.rad(angle1)
            local rad2 = math.rad(angle2)
            
            star.Position = Vector3.new(
                math.cos(rad1) * math.cos(rad2) * distance,
                math.sin(rad2) * distance,
                math.sin(rad1) * math.cos(rad2) * distance
            )
            star.Anchored = true
            star.CanCollide = false
            star.Material = Enum.Material.Neon
            star.Color = Color3.fromRGB(255, 255, math.random(200, 255))
            star.Parent = Workspace
            
            spawn(function()
                while ExecNoxx.NightMode and star.Parent do
                    star.Transparency = math.random(0, 0.5)
                    wait(math.random(1, 5) / 10)
                end
            end)
            
            table.insert(NightObjects, star)
        end
        
        -- Aurora
        for i = 1, 5 do
            local aurora = Instance.new("Part")
            aurora.Name = "ExecNight_Aurora" .. i
            aurora.Size = Vector3.new(3000, 100, 50)
            aurora.Position = Vector3.new(0, 500 + i * 80, -3000)
            aurora.Anchored = true
            aurora.CanCollide = false
            aurora.Material = Enum.Material.Neon
            aurora.Transparency = 0.6
            aurora.Parent = Workspace
            
            spawn(function()
                local colors = {
                    Color3.fromRGB(0, 255, 100),
                    Color3.fromRGB(0, 200, 255),
                    Color3.fromRGB(100, 0, 255),
                    Color3.fromRGB(255, 0, 200),
                    Color3.fromRGB(255, 100, 0)
                }
                local colorIndex = 1
                while ExecNoxx.NightMode and aurora.Parent do
                    aurora.Color = colors[colorIndex]
                    colorIndex = colorIndex + 1
                    if colorIndex > #colors then colorIndex = 1 end
                    aurora.Position = Vector3.new(
                        math.sin(tick() * 0.5 + i) * 500,
                        500 + i * 80 + math.sin(tick() + i) * 30,
                        -3000
                    )
                    wait(0.5)
                end
            end)
            
            table.insert(NightObjects, aurora)
        end
        
        -- Effects
        local AuroraCC = Instance.new("ColorCorrectionEffect")
        AuroraCC.Name = "ExecNight_AuroraCC"
        AuroraCC.TintColor = Color3.fromRGB(100, 255, 150)
        AuroraCC.Saturation = 0.4
        AuroraCC.Contrast = 0.15
        AuroraCC.Parent = Lighting
        
        local Bloom = Instance.new("BloomEffect")
        Bloom.Name = "ExecNight_Bloom"
        Bloom.Intensity = 1.0
        Bloom.Size = 56
        Bloom.Threshold = 0.4
        Bloom.Parent = Lighting
        
        local Blur = Instance.new("BlurEffect")
        Blur.Name = "ExecNight_Blur"
        Blur.Size = 3
        Blur.Parent = Lighting
    end)
end

local function DisableNightMode()
    ExecNoxx.NightMode = false
    for _, obj in pairs(NightObjects) do
        pcall(function() obj:Destroy() end)
    end
    NightObjects = {}
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect.Name:sub(1, 9) == "ExecNight" then
            pcall(function() effect:Destroy() end)
        end
    end
    
    if next(ExecNoxx.ShaderActive) ~= nil then
        ApplyShader()
    else
        ResetLighting()
    end
end

-- TP System
local function SmoothTP(targetPos, speed)
    local startPos = HumanoidRootPart.Position
    local distance = (targetPos - startPos).Magnitude
    local duration = distance / speed
    local startTime = tick()
    
    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        HumanoidRootPart.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        wait()
    end
    HumanoidRootPart.CFrame = CFrame.new(targetPos)
end

-- Create Tabs
local ExecNoxxPage = CreateTab("ExecNoxx", "⭐")
local ToolsPage = CreateTab("Tools", "🛠️")
local ShaderPage = CreateTab("Shader", "🎨")
local SinematikPage = CreateTab("Sinematik", "🎬")
local InfoPage = CreateTab("Info", "📊")

-- ExecNoxx Tab (Welcome)
CreateLabel(ExecNoxxPage, "SELAMAT DATANG DI EXECNOXX")
CreateLabel(ExecNoxxPage, "BOS KHOLIK EDITION")

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Name = "WelcomeText"
WelcomeText.Size = UDim2.new(1, -10, 0, 200)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = [[
     ███████╗██╗  ██╗███████╗ ██████╗██╗  ██╗ ██████╗ ██╗  ██╗██╗  ██╗
     ██╔════╝╚██╗██╔╝██╔════╝██╔════╝██║  ██║██╔═══██╗╚██╗██╔╝╚██╗██╔╝
     █████╗   ╚███╔╝ █████╗  ██║     ███████║██║   ██║ ╚███╔╝  ╚███╔╝ 
     ██╔══╝   ██╔██╗ ██╔══╝  ██║     ██╔══██║██║   ██║ ██╔██╗  ██╔██╗ 
     ███████╗██╔╝ ██╗███████╗╚██████╗██║  ██║╚██████╔╝██╔╝ ██╗██╔╝ ██╗
     ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
                           BOS KHOLIK EDITION]]
WelcomeText.TextColor3 = Colors.Text
WelcomeText.TextSize = 10
WelcomeText.Font = Enum.Font.Code
WelcomeText.TextWrapped = true
WelcomeText.Parent = ExecNoxxPage

CreateLabel(ExecNoxxPage, "Version: v1.0 BOS KHOLIK")
CreateLabel(ExecNoxxPage, "Made with ❤️ by ExecNoxx Team")

-- Tools Tab
CreateLabel(ToolsPage, "SHARELOK TAK PARANI")

local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Size = UDim2.new(1, -10, 0, 150)
PlayerListFrame.BackgroundColor3 = Colors.Button
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Parent = ToolsPage

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 10)
PlayerListCorner.Parent = PlayerListFrame

local PlayerListScroll = Instance.new("ScrollingFrame")
PlayerListScroll.Name = "PlayerListScroll"
PlayerListScroll.Size = UDim2.new(1, -20, 1, -50)
PlayerListScroll.Position = UDim2.new(0, 10, 0, 10)
PlayerListScroll.BackgroundTransparency = 1
PlayerListScroll.ScrollBarThickness = 4
PlayerListScroll.ScrollBarImageColor3 = Colors.Accent
PlayerListScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
PlayerListScroll.Parent = PlayerListFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 5)
PlayerListLayout.Parent = PlayerListScroll

PlayerListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y + 10)
end)

local SelectedPlayer = nil
local PlayerButtons = {}

local function UpdatePlayerList()
    for _, btn in pairs(PlayerButtons) do
        btn:Destroy()
    end
    PlayerButtons = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerBtn = Instance.new("TextButton")
            PlayerBtn.Name = player.Name .. "Btn"
            PlayerBtn.Size = UDim2.new(1, 0, 0, 35)
            PlayerBtn.BackgroundColor3 = Colors.Sidebar
            PlayerBtn.Text = player.DisplayName .. " (@" .. player.Name .. ")"
            PlayerBtn.TextColor3 = Colors.Text
            PlayerBtn.TextSize = 12
            PlayerBtn.Font = Enum.Font.GothamSemibold
            PlayerBtn.Parent = PlayerListScroll
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = PlayerBtn
            
            PlayerBtn.MouseButton1Click:Connect(function()
                SelectedPlayer = player
                for _, btn in pairs(PlayerButtons) do
                    btn.BackgroundColor3 = Colors.Sidebar
                end
                PlayerBtn.BackgroundColor3 = Colors.Accent
            end)
            
            table.insert(PlayerButtons, PlayerBtn)
        end
    end
    
    PlayerListScroll.CanvasSize = UDim2.new(0, 0, 0, #PlayerButtons * 40)
end

local ResetBtn = Instance.new("TextButton")
ResetBtn.Name = "ResetBtn"
ResetBtn.Size = UDim2.new(1, -20, 0, 30)
ResetBtn.Position = UDim2.new(0, 10, 1, -40)
ResetBtn.BackgroundColor3 = Colors.Accent
ResetBtn.Text = "🔄 Reset / Refresh Players"
ResetBtn.TextColor3 = Colors.Text
ResetBtn.TextSize = 12
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.Parent = PlayerListFrame

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 6)
ResetCorner.Parent = ResetBtn

ResetBtn.MouseButton1Click:Connect(UpdatePlayerList)

UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

CreateButton(ToolsPage, "📍 TP to Selected Player", function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SmoothTP(SelectedPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0), ExecNoxx.TPRange)
    end
end)

CreateButton(ToolsPage, "👁️ Spectate Selected Player", function()
    if SelectedPlayer and SelectedPlayer.Character then
        ExecNoxx.SpectateTarget = SelectedPlayer
        Workspace.CurrentCamera.CameraSubject = SelectedPlayer.Character:FindFirstChild("Humanoid") or SelectedPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    end
end)

CreateButton(ToolsPage, "🛑 Stop Spectating", function()
    ExecNoxx.SpectateTarget = nil
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            Workspace.CurrentCamera.CameraSubject = hum
        end
    end
end)

CreateLabel(ToolsPage, "TELEPORT TOOLS")

CreateToggle(ToolsPage, "TPTools", false, function(val)
    ExecNoxx.TPTools = val
    if val then
        spawn(function()
            while ExecNoxx.TPTools do
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                        local dist = (obj.Handle.Position - HumanoidRootPart.Position).Magnitude
                        if dist < 50 then
                            pcall(function()
                                obj.Handle.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                            end)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end)

CreateButton(ToolsPage, "🔧 TP to Closest Tool", function()
    local closestTool = nil
    local closestDist = math.huge
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            local dist = (obj.Handle.Position - HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestTool = obj
            end
        end
    end
    
    if closestTool then
        SmoothTP(closestTool.Handle.Position + Vector3.new(0, 3, 0), ExecNoxx.TPRange)
    end
end)

CreateLabel(ToolsPage, "MOVEMENT")

CreateToggle(ToolsPage, "Speed Walk", false, function(val)
    ExecNoxx.SpeedWalk = val
    if val then
        spawn(function()
            while ExecNoxx.SpeedWalk do
                if Humanoid then
                    Humanoid.WalkSpeed = ExecNoxx.WalkSpeed
                end
                wait(0.1)
            end
        end)
    else
        if Humanoid then
            Humanoid.WalkSpeed = 16
        end
    end
end)

CreateSlider(ToolsPage, "Walk Speed", 16, 1000, 16, function(val) 
    ExecNoxx.WalkSpeed = val
    if ExecNoxx.SpeedWalk and Humanoid then
        Humanoid.WalkSpeed = val
    end
end)

CreateToggle(ToolsPage, "JPower", false, function(val)
    ExecNoxx.JPower = val
    if val and Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = ExecNoxx.JumpPower
    elseif Humanoid then
        Humanoid.JumpPower = 50
    end
end)

CreateSlider(ToolsPage, "Jump Power", 50, 1000, 50, function(val)
    ExecNoxx.JumpPower = val
    if ExecNoxx.JPower and Humanoid then
        Humanoid.JumpPower = val
    end
end)

CreateToggle(ToolsPage, "Gravity Control", false, function(val)
    ExecNoxx.GravityEnabled = val
    if val then
        Workspace.Gravity = 196
    end
end)

CreateSlider(ToolsPage, "Gravity", 1, 1000, 196, function(val) 
    if ExecNoxx.GravityEnabled then
        Workspace.Gravity = val
    end
end)

CreateToggle(ToolsPage, "INF JUMP", false, function(val)
    ExecNoxx.InfiniteJump = val
end)

UserInputService.JumpRequest:Connect(function()
    if ExecNoxx.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CreateToggle(ToolsPage, "Fly", false, function(val)
    ExecNoxx.Fly = val
    if val then
        local BG = Instance.new("BodyGyro")
        local BV = Instance.new("BodyVelocity")
        BG.P = 9e4; BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9); BG.CFrame = HumanoidRootPart.CFrame
        BV.Velocity = Vector3.new(0, 0, 0); BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BG.Parent = HumanoidRootPart; BV.Parent = HumanoidRootPart
        spawn(function()
            while ExecNoxx.Fly do
                local cam = Workspace.CurrentCamera
                local md = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then md = md + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then md = md - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then md = md - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then md = md + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then md = md + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then md = md - Vector3.new(0, 1, 0) end
                BV.Velocity = md * ExecNoxx.FlySpeed; BG.CFrame = cam.CFrame
                wait()
            end
            BG:Destroy(); BV:Destroy()
        end)
    end
end)

CreateSlider(ToolsPage, "Fly Speed", 10, 200, 50, function(val) ExecNoxx.FlySpeed = val end)

CreateToggle(ToolsPage, "Noclip", false, function(val)
    ExecNoxx.Noclip = val
    if val then
        spawn(function()
            while ExecNoxx.Noclip do
                if Character then 
                    for _, p in pairs(Character:GetDescendants()) do 
                        if p:IsA("BasePart") then 
                            p.CanCollide = false 
                        end 
                    end 
                end
                wait()
            end
            if Character then 
                for _, p in pairs(Character:GetDescendants()) do 
                    if p:IsA("BasePart") then 
                        p.CanCollide = true 
                    end 
                end 
            end
        end)
    end
end)

CreateLabel(ToolsPage, "SPECIAL FEATURES")

CreateToggle(ToolsPage, "Invis", false, function(val)
    ExecNoxx.Invisible = val
    if val and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    elseif Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0
            end
        end
    end
end)

CreateToggle(ToolsPage, "God Mode", false, function(val)
    ExecNoxx.GodMode = val
    if val then
        spawn(function()
            while ExecNoxx.GodMode do
                if Humanoid then
                    Humanoid.MaxHealth = math.huge
                    Humanoid.Health = math.huge
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                end
                wait(0.1)
            end
            if Humanoid then
                Humanoid.MaxHealth = 100
                Humanoid.Health = 100
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            end
        end)
    end
end)

CreateLabel(ToolsPage, "AUTO CLICK")

CreateToggle(ToolsPage, "Auto Click", false, function(val)
    ExecNoxx.AutoClick = val
end)

CreateSlider(ToolsPage, "Click Speed (0.1-5s)", 1, 50, 10, function(val)
    ExecNoxx.AutoClickSpeed = val / 10
end)

-- Auto Click System (Non-blocking)
spawn(function()
    while true do
        if ExecNoxx.AutoClick then
            pcall(function()
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end)
            wait(ExecNoxx.AutoClickSpeed)
        else
            wait(0.1)
        end
    end
end)

-- Shader Tab
CreateLabel(ShaderPage, "SMOOTH & HD SHADERS")

CreateToggle(ShaderPage, "120FPS", false, function(val) 
    if val then ApplyShader("120FPS") else RemoveShader("120FPS") end 
end)

CreateToggle(ShaderPage, "SMOOTH", false, function(val) 
    if val then ApplyShader("SMOOTH") else RemoveShader("SMOOTH") end 
end)

CreateToggle(ShaderPage, "SOFT", false, function(val) 
    if val then ApplyShader("SOFT") else RemoveShader("SOFT") end 
end)

CreateToggle(ShaderPage, "HD", false, function(val) 
    if val then ApplyShader("HD") else RemoveShader("HD") end 
end)

CreateToggle(ShaderPage, "4K", false, function(val) 
    if val then ApplyShader("4K") else RemoveShader("4K") end 
end)

CreateToggle(ShaderPage, "iPcam", false, function(val) 
    if val then ApplyShader("iPcam") else RemoveShader("iPcam") end 
end)

CreateLabel(ShaderPage, "SPECIAL MODES")

CreateToggle(ShaderPage, "🌙 Night Mode (Epic)", false, function(val)
    if val then ApplyNightMode() else DisableNightMode() end
end)

CreateLabel(ShaderPage, "RESET")

CreateButton(ShaderPage, "🗑️ Reset All Shaders", function()
    ClearAllShaders()
    ResetLighting()
end)

-- Sinematik Tab (Free Cam)
CreateLabel(SinematikPage, "FREE CAMERA (DRONE MODE)")

local FreeCamActive = false
local FreeCamCamera = nil
local FreeCamPart = nil

CreateToggle(SinematikPage, "FreeCam", false, function(val)
    ExecNoxx.FreeCam = val
    if val then
        spawn(function()
            local camera = Workspace.CurrentCamera
            FreeCamPart = Instance.new("Part")
            FreeCamPart.Name = "FreeCamPart"
            FreeCamPart.Size = Vector3.new(1, 1, 1)
            FreeCamPart.Anchored = true
            FreeCamPart.CanCollide = false
            FreeCamPart.Transparency = 1
            FreeCamPart.CFrame = camera.CFrame
            FreeCamPart.Parent = Workspace
            
            FreeCamCamera = Instance.new("Camera")
            FreeCamCamera.CameraType = Enum.CameraType.Scriptable
            FreeCamCamera.CFrame = camera.CFrame
            FreeCamCamera.FieldOfView = camera.FieldOfView
            
            Workspace.CurrentCamera = FreeCamCamera
            
            local speed = 2
            while ExecNoxx.FreeCam and FreeCamPart.Parent do
                local cf = FreeCamPart.CFrame
                local newCf = cf
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    newCf = newCf * CFrame.new(0, 0, -speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    newCf = newCf * CFrame.new(0, 0, speed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    newCf = newCf * CFrame.new(-speed, 0, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    newCf = newCf * CFrame.new(speed, 0, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    newCf = newCf * CFrame.new(0, speed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    newCf = newCf * CFrame.new(0, -speed, 0)
                end
                
                -- Arrow keys for rotation
                if UserInputService:IsKeyDown(Enum.KeyCode.Up) then
                    newCf = newCf * CFrame.Angles(math.rad(2), 0, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Down) then
                    newCf = newCf * CFrame.Angles(math.rad(-2), 0, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Left) then
                    newCf = newCf * CFrame.Angles(0, math.rad(-2), 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Right) then
                    newCf = newCf * CFrame.Angles(0, math.rad(2), 0)
                end
                
                FreeCamPart.CFrame = newCf
                FreeCamCamera.CFrame = newCf
                wait()
            end
            
            if FreeCamPart then FreeCamPart:Destroy() end
            if FreeCamCamera then FreeCamCamera:Destroy() end
            Workspace.CurrentCamera = camera
        end)
    end
end)

CreateButton(SinematikPage, "⬆️ Look Up", function()
    if FreeCamPart then
        FreeCamPart.CFrame = FreeCamPart.CFrame * CFrame.Angles(math.rad(45), 0, 0)
    end
end)

CreateButton(SinematikPage, "⬇️ Look Down", function()
    if FreeCamPart then
        FreeCamPart.CFrame = FreeCamPart.CFrame * CFrame.Angles(math.rad(-45), 0, 0)
    end
end)

CreateButton(SinematikPage, "⬅️ Look Left", function()
    if FreeCamPart then
        FreeCamPart.CFrame = FreeCamPart.CFrame * CFrame.Angles(0, math.rad(-45), 0)
    end
end)

CreateButton(SinematikPage, "➡️ Look Right", function()
    if FreeCamPart then
        FreeCamPart.CFrame = FreeCamPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
    end
end)

CreateButton(SinematikPage, "🧭 North", function()
    if FreeCamPart then
        local pos = FreeCamPart.Position
        FreeCamPart.CFrame = CFrame.new(pos) * CFrame.Angles(0, 0, 0)
    end
end)

CreateButton(SinematikPage, "🧭 East", function()
    if FreeCamPart then
        local pos = FreeCamPart.Position
        FreeCamPart.CFrame = CFrame.new(pos) * CFrame.Angles(0, math.rad(-90), 0)
    end
end)

CreateButton(SinematikPage, "🧭 South", function()
    if FreeCamPart then
        local pos = FreeCamPart.Position
        FreeCamPart.CFrame = CFrame.new(pos) * CFrame.Angles(0, math.rad(180), 0)
    end
end)

CreateButton(SinematikPage, "🧭 West", function()
    if FreeCamPart then
        local pos = FreeCamPart.Position
        FreeCamPart.CFrame = CFrame.new(pos) * CFrame.Angles(0, math.rad(90), 0)
    end
end)

-- Info Tab
CreateLabel(InfoPage, "SERVER INFORMATION")

CreateCopyButton(InfoPage, "Job ID", game.JobId)
CreateCopyButton(InfoPage, "Server ID", game.JobId:sub(1, 8) .. "-" .. game.JobId:sub(9, 12))

CreateLabel(InfoPage, "SERVER HOP")

CreateButton(InfoPage, "🔄 Hop Server (1-5 Players)", function()
    local servers = {}
    local req = syn and syn.request or http_request or request
    if req then
        local res = req({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        if res and res.Body then
            local data = HttpService:JSONDecode(res.Body)
            for _, server in pairs(data.data) do
                if server.playing >= 1 and server.playing <= 5 then
                    table.insert(servers, server.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
            else
                warn("No servers with 1-5 players found")
            end
        end
    end
end)

CreateButton(InfoPage, "🔄 Hop Server (1-3 Players)", function()
    local servers = {}
    local req = syn and syn.request or http_request or request
    if req then
        local res = req({
            Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
            Method = "GET"
        })
        if res and res.Body then
            local data = HttpService:JSONDecode(res.Body)
            for _, server in pairs(data.data) do
                if server.playing >= 1 and server.playing <= 3 then
                    table.insert(servers, server.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
            else
                warn("No servers with 1-3 players found")
            end
        end
    end
end)

local PlayersContainer, PlayersLabel = CreateInfoLabel(InfoPage, "Players: Loading...")
local TimeContainer, TimeLabel = CreateInfoLabel(InfoPage, "Game Time: Loading...")

local UptimeContainer, UptimeLabel = CreateInfoLabel(InfoPage, "Server Uptime: Loading...")

spawn(function()
    while true do
        local elapsed = tick() - ExecNoxx.ServerStartTime
        local days = math.floor(elapsed / 86400)
        local hours = math.floor((elapsed % 86400) / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)
        
        UptimeLabel.Text = string.format("Server Uptime: %d Days, %02d Hours, %02d Minutes, %02d Seconds", 
            days, hours, minutes, seconds)
        
        PlayersLabel.Text = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
        TimeLabel.Text = "Game Time: " .. math.floor(Lighting.ClockTime) .. ":00"
        
        wait(1)
    end
end)

local PingContainer, PingLabel = CreateInfoLabel(InfoPage, "Ping: Loading...")

local SignalFrame = Instance.new("Frame")
SignalFrame.Name = "SignalFrame"
SignalFrame.Size = UDim2.new(0, 60, 0, 40)
SignalFrame.Position = UDim2.new(1, -70, 0, 10)
SignalFrame.BackgroundTransparency = 1
SignalFrame.Parent = PingContainer

local bars = {}
for i = 1, 4 do
    local bar = Instance.new("Frame")
    bar.Name = "Bar" .. i
    bar.Size = UDim2.new(0, 8, 0, i * 8)
    bar.Position = UDim2.new(0, (i-1) * 12, 1, -i * 8)
    bar.BackgroundColor3 = Colors.Green
    bar.BorderSizePixel = 0
    bar.Parent = SignalFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 2)
    barCorner.Parent = bar
    
    table.insert(bars, bar)
end

spawn(function()
    while true do
        local ping = Stats.PerformanceStats.Ping:GetValue()
        PingLabel.Text = "Ping: " .. math.floor(ping) .. " ms"
        
        local signalColor = Colors.Green
        local activeBars = 4
        if ping > 300 then
            signalColor = Colors.Red
            activeBars = 1
        elseif ping > 150 then
            signalColor = Colors.Yellow
            activeBars = 2
        elseif ping > 80 then
            signalColor = Colors.Yellow
            activeBars = 3
        end
        
        for i, bar in pairs(bars) do
            if i <= activeBars then
                bar.BackgroundColor3 = signalColor
                bar.BackgroundTransparency = 0
            else
                bar.BackgroundTransparency = 0.7
            end
        end
        
        wait(1)
    end
end)

CreateLabel(InfoPage, "LOCAL PLAYER INFO")

local LocalContainer, LocalLabel = CreateInfoLabel(InfoPage, "Loading...")

spawn(function()
    while true do
        local info = "Name: " .. LocalPlayer.Name .. "\n"
        info = info .. "Display: " .. LocalPlayer.DisplayName .. "\n"
        info = info .. "UserId: " .. LocalPlayer.UserId .. "\n"
        info = info .. "Account Age: " .. LocalPlayer.AccountAge .. " days"
        LocalLabel.Text = info
        wait(5)
    end
end)

-- Select first tab
wait(0.1)
for _, child in pairs(TabList:GetChildren()) do
    if child:IsA("TextButton") then
        child.MouseButton1Click:Fire()
        break
    end
end

-- Drag Main GUI
local Dragging = false
local DragInput = nil
local DragStart = nil
local StartPos = nil

TopBar.InputBegan:Connect(function(input)
    if ExecNoxx.GUI.Locked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        DragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == DragInput and Dragging and not ExecNoxx.GUI.Locked then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

print("=== EXECNOXX v1.0 BOS KHOLIK EDITION LOADED ===")
print("Features: Intro, TPTools, JPower, Invis, God Mode, AutoClick")
print("Tabs: ExecNoxx, Tools, Shader, Sinematik, Info")
print("FreeCam, Server Hop, Epic Night Mode")

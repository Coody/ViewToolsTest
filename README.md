# ViewToolsTest 
![建立者](https://img.shields.io/badge/建立者-Coody-orange.svg)

1. ViewTools
用來快速建立 UIButton , UILabel , UITextField 套組元件的工具。
2. ContainerView
用來排版的工具 , 可以設定左右排列、或是上下排列。

# 改版說明
2.0 版本將 ContainerView 獨立出來

# 類別說明
ViewToolsClass 資料夾裡面包含三個類別：
* ViewTools 類別：專門產生各類的 UIView 元件（如：UILabel , UITextField , UIButton ... 等）
* ContainerView 類別：專門將 ViewTools 類別所產生的 UIView 元件左右排版好、並且產生適當寬度。
* UITextFieldTools 類別：擴充 UITextField 的辨識字元、截斷字元功能

# 使用方式
#### ViewTools & ContainerView
* 將 ViewTools.h , ViewTools.m 類別加入專案，
* 支援的UIView 元件： UILabel , UITextField , UIButton , 繼承自 UIView 的類別。
* ContainerView 可以將上述的元件加入後、依照左右排列（或是從右邊元件為主由右往左計算大小排列），來產生各種您想要的元件。

#### UITextFieldTools
* （待補）

# DEMO
>（待補）

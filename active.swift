import Cocoa

class OverlayWindow: NSWindow {
    override var canBecomeKey: Bool { return false }
}

let screenFrame = NSScreen.main!.frame
let overlaySize = NSSize(width: 300, height: 80) // Ajuste o tamanho conforme necessário

let window = OverlayWindow(
    contentRect: NSRect(x: screenFrame.width - overlaySize.width - 20, 
                        y: 85, // Ajuste a posição vertical para ficar acima da dock
                        width: overlaySize.width, 
                        height: overlaySize.height),
    styleMask: .borderless,
    backing: .buffered,
    defer: false
)

window.isOpaque = false
window.backgroundColor = NSColor.clear
window.level = .screenSaver
window.ignoresMouseEvents = true

let contentView = NSView(frame: window.frame)
contentView.wantsLayer = true
contentView.layer?.backgroundColor = NSColor.clear.cgColor // Removendo o fundo transparente

let boldLabel = NSTextField(labelWithString: "Active macOS")
boldLabel.font = NSFont.systemFont(ofSize: 20, weight: .medium) // Fonte "Medium" para um negrito mais fino
boldLabel.textColor = NSColor.white.withAlphaComponent(0.5) // Transparência nas letras
boldLabel.backgroundColor = .clear
boldLabel.alignment = .left
boldLabel.frame = CGRect(x: 10, y: 40, width: overlaySize.width - 20, height: 25)

let regularLabel = NSTextField(labelWithString: "Go to Settings to activate your macOS")
regularLabel.font = NSFont.systemFont(ofSize: 14) // Fonte ligeiramente menor
regularLabel.textColor = NSColor.white.withAlphaComponent(0.5) // Transparência nas letras
regularLabel.backgroundColor = .clear
regularLabel.alignment = .left
regularLabel.frame = CGRect(x: 10, y: 15, width: overlaySize.width - 20, height: 20)

contentView.addSubview(boldLabel)
contentView.addSubview(regularLabel)
window.contentView = contentView
window.makeKeyAndOrderFront(nil)

RunLoop.main.run()
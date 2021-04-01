//
//  Renderer.swift
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//  Comments Credit: https://developer.apple.com/documentation/metal
//

import MetalKit

/**
 Contains methods for responding to a MetalKit view's drawing and resizing events.
 */
public class Renderer: NSObject {
    
    private var mtlDevice: MTLDevice!
    
    /**
     A MTLCommandQueue object queues an ordered list of command buffers for a MTLDevice to execute
     */
    private var commandQueue: MTLCommandQueue!
    
    private var triangle: Triangle!
    
    init(withDevice device: MTLDevice) {
        super.init()
        
        self.mtlDevice = device
        self.commandQueue = self.mtlDevice.makeCommandQueue()
        self.triangle = Triangle(withDevice: self.mtlDevice)
    }
}

/**
 Use a delegate to provide a drawing method to a MTKView object and respond to rendering events without subclassing the MTKView class.
 */
extension Renderer: MTKViewDelegate {
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    public func draw(in view: MTKView) {
        let commandBuffer: MTLCommandBuffer = self.commandQueue.makeCommandBuffer()!
        let renderPassDescriptor: MTLRenderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].texture = view.currentDrawable!.texture
        
        let renderCommandEncoder: MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        
        self.triangle.draw(renderCommandEncoder:  renderCommandEncoder)
        
        renderCommandEncoder.endEncoding()
        
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
}

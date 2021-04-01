//
//  MetalView.swift
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//  Comments Credit: https://developer.apple.com/documentation/metal
//

import MetalKit

/**
 The MetalView sub class of MTKView provides a default implementation of a Metal-aware view that you can use to render graphics using Metal and display them onscreen
 */
public class MetalView: MTKView {
    
    //Renderer has methods for responding to a MetalKit view's drawing and resizing events.
    private var renderer: Renderer!
    
    init(frame: CGRect) {
        super.init(frame: frame, device: nil)
        self.configureMetalView()
    }
    
    private func configureMetalView() {
        guard let mtlDevice = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal is not supported by the device")
        }
        
        self.device = mtlDevice
        self.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.renderer = Renderer(withDevice: self.device!)
        self.delegate = self.renderer
    }
    
    public func changeRenderType(to type: RenderType) {
        self.renderer.changeRenderType(to: type)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

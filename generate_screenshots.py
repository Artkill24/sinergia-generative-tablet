#!/usr/bin/env python3
"""
Script per generare screenshots del simulatore in headless mode
"""

import pygame
import sys
import os
from hardware_simulator.main import SinerGiaSimulator, DeviceMode

# Setup headless display
os.environ['SDL_VIDEODRIVER'] = 'dummy'

def generate_screenshots():
    """Genera screenshots di tutte le modalità"""
    
    print("🎮 Inizializzando simulatore in headless mode...")
    
    # Crea directory screenshots
    os.makedirs('assets/screenshots', exist_ok=True)
    
    # Inizializza simulatore
    sim = SinerGiaSimulator()
    
    # Lista modalità
    modes = [
        (DeviceMode.SKETCH, "sketch_mode"),
        (DeviceMode.WORLD, "world_mode"),
        (DeviceMode.DIALOGUE, "dialogue_mode")
    ]
    
    for mode, filename in modes:
        print(f"📸 Generando screenshot per {mode.value}...")
        
        # Cambia modalità
        sim.current_mode = mode
        
        # Renderizza UI
        sim.render_ui()
        
        # Salva screenshot
        screenshot_path = f'assets/screenshots/{filename}.png'
        pygame.image.save(sim.screen, screenshot_path)
        
        print(f"✅ Salvato: {screenshot_path}")
    
    print("\n🎉 Screenshots generati con successo!")
    print("\nFile creati:")
    for _, filename in modes:
        print(f"  - assets/screenshots/{filename}.png")
    
    pygame.quit()

if __name__ == "__main__":
    generate_screenshots()

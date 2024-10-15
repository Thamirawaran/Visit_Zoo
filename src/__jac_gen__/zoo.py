from __future__ import annotations
from jaclang import jac_import as __jac_import__
import typing as _jac_typ
if _jac_typ.TYPE_CHECKING:
    import pygame
else:
    pygame, = __jac_import__(target='pygame', base_path=__file__, lng='py', absorb=False, mdl_alias=None, items={})
if _jac_typ.TYPE_CHECKING:
    import sys
else:
    sys, = __jac_import__(target='sys', base_path=__file__, lng='py', absorb=False, mdl_alias=None, items={})
if _jac_typ.TYPE_CHECKING:
    from gui import GUI
else:
    GUI, = __jac_import__(target='gui', base_path=__file__, lng='py', absorb=False, mdl_alias=None, items={'GUI': None})
if _jac_typ.TYPE_CHECKING:
    from model import Section
else:
    Section, = __jac_import__(target='model', base_path=__file__, lng='py', absorb=False, mdl_alias=None, items={'Section': None})
if _jac_typ.TYPE_CHECKING:
    from users import HistoryManager
else:
    HistoryManager, = __jac_import__(target='users', base_path=__file__, lng='py', absorb=False, mdl_alias=None, items={'HistoryManager': None})

def zoo() -> None:
    pygame.init()
    WIDTH, HEIGHT = (800, 600)
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption('Zoo Management Game')
    clock = pygame.time.Clock()
    FPS = 60
    history_manager = HistoryManager()
    gui = GUI(screen, history_manager)
    sections = [Section(name='Common', position=(400, 300), image_path='common.png', enabled=True), Section(name='Animals', position=(300, 200), image_path='animals.png'), Section(name='Birds', position=(500, 200), image_path='birds.png'), Section(name='Fish', position=(300, 400), image_path='fish.png'), Section(name='Museum', position=(500, 400), image_path='museum.png'), Section(name='Lion', position=(200, 100), image_path='lion.png'), Section(name='Elephant', position=(100, 150), image_path='elephant.png'), Section(name='Parrot', position=(600, 100), image_path='parrot.png'), Section(name='Humming', position=(700, 150), image_path='humming.png'), Section(name='Dolphin', position=(200, 500), image_path='dolphin.png'), Section(name='Gold', position=(100, 450), image_path='gold.png')]
    connections = {'Common': ['Animals', 'Birds', 'Fish', 'Museum'], 'Animals': ['Lion', 'Elephant'], 'Birds': ['Parrot', 'Humming'], 'Fish': ['Dolphin', 'Gold'], 'Museum': []}
    section_dict = {section.name: section for section in sections}
    for parent, children in connections.items():
        parent_section = section_dict[parent]
        for child in children:
            child_section = section_dict[child]
            parent_section.connected_sections.append(child_section)
    for section in sections:
        gui.add_section(section, parent=section_dict.get(section.name, None))
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 1:
                    gui.handle_click(event.pos)
        gui.render()
        clock.tick(FPS)
    pygame.quit()
    sys.exit()
if __name__ == '__main__':
    zoo()
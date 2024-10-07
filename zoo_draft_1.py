from __future__ import annotations
from jaclang.plugin.feature import JacFeature as _Jac
from jaclang.plugin.builtin import *
from dataclasses import dataclass as __jac_dataclass__

@_Jac.make_node(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class section(_Jac.Node):
    name: str

@_Jac.make_edge(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class road(_Jac.Edge):
    distance: int

@_Jac.make_walker(on_entry=[_Jac.DSFunc('take_photo', None), _Jac.DSFunc('Visit', None)], on_exit=[])
@__jac_dataclass__(eq=False)
class VIP(_Jac.Walker):
    name: str
    count: int = _Jac.has_instance_default(gen_func=lambda: 1)

    def take_photo(self, _jac_here_) -> None:
        print(f'You took {self.count} photos')
        print('Photo', _jac_here_)

    def Visit(self, _jac_here_) -> None:
        print('Visit', _jac_here_)

@_Jac.make_walker(on_entry=[], on_exit=[])
@__jac_dataclass__(eq=False)
class Normal(_Jac.Walker):
    name: str
    count: int = _Jac.has_instance_default(gen_func=lambda: 1)
Common = section(name='Common')
Museum = section(name='Museum')
A_canteen = section(name='Canteen')
B_canteen = section(name='Canteen')
C_canteen = section(name='Canteen')
S_canteen = section(name='Canteen')
Animals = section(name='Animals')
Lion = section(name='Lion')
Elephant = section(name='Elephant')
Cheetah = section(name='Cheetah')
Buffalo = section(name='Buffalo')
Birds = section(name='Birds')
Parrot = section(name='Parrot')
Hummingbirds = section(name='Hummingbirds')
Snake = section(name='Snake')
_Jac.connect(left=_Jac.get_root(), right=Common, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=0), conn_assign=None))
_Jac.connect(left=Common, right=Animals, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Common, right=Birds, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=20), conn_assign=None))
_Jac.connect(left=Common, right=Snake, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=30), conn_assign=None))
_Jac.connect(left=Common, right=Museum, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=30), conn_assign=None))
_Jac.connect(left=Common, right=C_canteen, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Animals, right=A_canteen, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Birds, right=B_canteen, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Snake, right=S_canteen, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Animals, right=Lion, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Animals, right=Elephant, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Animals, right=Cheetah, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Animals, right=Buffalo, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Birds, right=Parrot, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
_Jac.connect(left=Birds, right=Hummingbirds, edge_spec=_Jac.build_edge(is_undirected=False, conn_type=road(distance=10), conn_assign=None))
User1 = VIP('User1')
User2 = Normal('Sipho')
_Jac.spawn_call(_Jac.get_root(), User1)
_Jac.spawn_call(_Jac.get_root(), User2)
print(User1)
print(User2)
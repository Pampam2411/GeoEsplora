import 'package:geoesplora/models/geosite.dart';
import 'package:geoesplora/models/rock.dart';

class MockData {
  static final List<Rock> mockRocks = [
    Rock(
      id: 'r1',
      name: 'Granito',
      type: 'Ignea Intrusiva',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b',
      geologicalEra: 'Paleozoico',
      description:
          'Una roccia dura e resistente, tipica dell\'altopiano silano, caratterizzata da grossi cristalli di quarzo e feldspato.',
      density: 7.0,
      porosity: 15,
      resistence: 250,
    ),
    Rock(
      id: 'r2',
      name: 'Calcare Appenninico',
      type: 'Sedimentaria',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b',
      geologicalEra: 'Mesozoico',
      description:
          'Roccia sedimentaria chiara, formatasi in antichi mari bassi e caldi. Spesso contiene fossili.',
      density: 3.5,
      porosity: 15,
      resistence: 250,
    ),
  ];

  static final List<Geosite> mockGeosites = [
    Geosite(
      id: 'g1',
      name: 'Grotte di Frasassi (Calabrese)',
      location: 'Cosenza, Calabria',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b',
      rating: 4.8,
      reviewCount: 143,
      description:
          'Un incredibile complesso carsico sotterraneo, ricco di stalattiti e stalagmiti modellate dall\'acqua nel corso dei millenni. Un viaggio al centro della terra.',
      duration: '3 ore',
      distance: '1 km',
      price: '€ 15',
      isAccessible: false,
      rockIds: ['r2'],
    ),
    Geosite(
      id: 'g2',
      name: 'Pietra dell\'Incudine',
      location: 'Reggio Calabria, Calabria',
      imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b',
      rating: 4.5,
      reviewCount: 89,
      description:
          'Un enorme monolite di granito che si erge isolato nel bosco, modellato dal vento e dall\'erosione fino ad assumere la forma di una gigantesca incudine.',
      duration: '1.5 ore',
      distance: '0.5 km',
      price: 'Gratis',
      isAccessible: true,
      rockIds: ['r1'],
    ),
    Geosite(
      id: 'g3',
      name: 'Valli Cupe',
      location: 'Catanzaro, Calabria',
      imageUrl: 'https://images.unsplash.com/photo-1542224566-6e85f2e6772f',
      rating: 4.9,
      reviewCount: 256,
      description:
          'Profondi canyon scavati nella roccia sedimentaria, con pareti a strapiombo, cascate nascoste e una vegetazione lussureggiante.',
      duration: '4 ore',
      distance: '3.2 km',
      price: '€ 8',
      isAccessible: false,
      rockIds: ['r2'],
    ),
  ];
}

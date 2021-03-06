import Combine
import Core
import Foundation
import Network
import Support

public final class HeroService: HeroServicing {

    private let provider: HeroProvider

    public init(provider: HeroProvider) {
        self.provider = provider
    }

    public func heroes() -> AnyPublisher<[Core.Hero], Error> {
        provider.heroes()
            .map { $0.data.results.compactMap(Core.Hero.init) }
            .eraseToAnyPublisher()
    }

    public func hero(by id: Int) -> AnyPublisher<Core.Hero, Error> {
        provider.hero(by: id)
            .tryMap { try $0.data.results.first ?? MarvelError.emptyArraySearchCharacterById }
            .tryMap { try Core.Hero(hero: $0) ?? MarvelError.unsufficientFields }
            .eraseToAnyPublisher()
    }

}

extension Core.Hero {
    init?(hero: Hero) {
        guard let id = hero.id, let name = hero.name, let thumbnail = hero.thumbnail else { return nil }
        self.init(id: id,
                  name: name,
                  description: hero.description,
                  image: thumbnail.url,
                  comics: hero.comics.items.compactMap(\.name),
                  stories: hero.stories.items.compactMap(\.name),
                  series: hero.series.items.compactMap(\.name))
    }
}

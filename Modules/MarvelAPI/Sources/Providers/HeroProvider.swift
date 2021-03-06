import Combine
import Foundation
import Network

public final class HeroProvider {

    private let client: HTTPPerforming

    public init(client: HTTPPerforming) {
        self.client = client
    }

    func heroes() -> AnyPublisher<Response<Page<[Hero]>>, Error> {
        client.perform(get("/v1/public/characters"))
    }

    func hero(by id: Int) -> AnyPublisher<Response<Page<[Hero]>>, Error> {
        client.perform(get("/v1/public/characters/\(id)"))
    }

}

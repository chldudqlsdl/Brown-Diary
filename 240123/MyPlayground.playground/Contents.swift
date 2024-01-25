import UIKit

let resource: Resource<SearchUserResponse> = Resource(
    base: "https://api.github.com/",
    path: "search/users",
    params: ["q": keyword],
    header: ["Content-Type": "application/json"]
)

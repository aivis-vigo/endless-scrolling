//
//  endless_scrollingUITests.swift
//  endless-scrollingUITests
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import XCTest

final class endless_scrollingUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testTabBarButtonAmount() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let homeTab = tabBar.buttons["Home"]
        XCTAssertTrue(homeTab.exists)

        let searchTab = tabBar.buttons["Search"]
        XCTAssertTrue(searchTab.exists)

        XCTAssertEqual(tabBar.buttons.count, 2)
    }

    @MainActor
    func testTabBarNavigation() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let searchTab = tabBar.buttons["Search"]
        searchTab.tap()

        XCTAssertTrue(searchTab.isSelected)

        let homeTab = tabBar.buttons["Home"]
        homeTab.tap()

        XCTAssertTrue(homeTab.isSelected)
    }

    @MainActor
    func testSearchBarResults() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let searchTab = tabBar.buttons["Search"]
        searchTab.tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))

        searchField.tap()
        searchField.typeText("cat")

        let firstImage = app.images.firstMatch
        XCTAssertTrue(firstImage.waitForExistence(timeout: 5))
    }

    @MainActor
    func testResultsDisappearAfterClear() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let searchTab = tabBar.buttons["Search"]
        searchTab.tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))

        searchField.tap()
        searchField.typeText("cat")

        let gifContainers = app.otherElements.matching(
            identifier: "gifContainer"
        )

        let firstGif = gifContainers.element(boundBy: 0)
        XCTAssertTrue(firstGif.waitForExistence(timeout: 5))

        let loadedGifsCount = gifContainers.count
        XCTAssertGreaterThan(loadedGifsCount, 0, "Should have loaded GIFs")

        let clearButton = searchField.buttons["Clear text"]
        XCTAssertTrue(clearButton.waitForExistence(timeout: 2))
        clearButton.tap()

        sleep(2)

        let remainingGifsCount = gifContainers.count
        XCTAssertEqual(
            remainingGifsCount,
            0,
            "GIFs should have disappeard after clearing search input"
        )
    }

    @MainActor
    func testLimitedSearchResults() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let searchTab = tabBar.buttons["Search"]
        searchTab.tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))

        searchField.tap()
        searchField.typeText("cat")

        let gifContainers = app.otherElements.matching(
            identifier: "gifContainer"
        )

        let firstGif = gifContainers.element(boundBy: 0)
        XCTAssertTrue(firstGif.waitForExistence(timeout: 5))

        sleep(2)

        let initialLoadedGifsCount = gifContainers.count
        XCTAssertGreaterThan(
            initialLoadedGifsCount,
            0,
            "Should have loaded GIFs"
        )
        XCTAssertLessThanOrEqual(
            initialLoadedGifsCount,
            25,
            "Should not load more than 25 GIFs"
        )

        let scrollView = app.scrollViews.firstMatch

        for _ in 0..<5 {
            scrollView.swipeUp()
            sleep(1)
        }

        sleep(2)

        let afterScrollGifsCount = gifContainers.count
        XCTAssertLessThanOrEqual(
            afterScrollGifsCount,
            initialLoadedGifsCount,
            "Should not load more gifs after scrolling"
        )
    }

    @MainActor
    func testTrendingImagesInfiniteScroll() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 3))

        let homeTab = tabBar.buttons["Home"]
        homeTab.tap()

        let gifContainers = app.otherElements.matching(
            identifier: "gifContainer"
        )
        let firstGif = gifContainers.element(boundBy: 0)
        XCTAssertTrue(firstGif.waitForExistence(timeout: 5))

        sleep(2)

        let initialCount = gifContainers.count
        XCTAssertGreaterThan(
            initialCount,
            0,
            "Should have loaded trending GIFs"
        )

        let scrollView = app.scrollViews.firstMatch
        for _ in 0..<5 {
            scrollView.swipeUp()
            sleep(1)
        }

        sleep(3)

        let afterScrollCount = gifContainers.count
        XCTAssertGreaterThan(
            afterScrollCount,
            initialCount,
            "More trending GIFs should load after scrolling (initial: \(initialCount), after: \(afterScrollCount))"
        )
    }

    @MainActor
    func testTappingTrendingGifNavigatesToDetails() throws {
        let app = XCUIApplication()
        app.launch()

        // Ensure Home tab
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.waitForExistence(timeout: 3))
        homeTab.tap()

        let gifContainers = app.otherElements.matching(
            identifier: "gifContainer"
        )

        let firstGif = gifContainers.element(boundBy: 0)

        XCTAssertTrue(
            firstGif.waitForExistence(timeout: 5),
            "Expected trending GIF container to be visible"
        )

        XCTAssertTrue(
            firstGif.isHittable,
            "GIF container should be tappable"
        )

        firstGif.tap()

        let detailsView = app.otherElements["selectedGif"]
        XCTAssertTrue(
            detailsView.waitForExistence(timeout: 3),
            "Expected navigation to ImageDetailsView"
        )
    }

}

//
//  SnappThemingImageManagerTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/7/25.
//

import Foundation
import Testing

@testable import SnappTheming

@Suite
struct SnappThemingImageManagerTests {
    // Successes
    @Test func testPreparingImage_PNG() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue,
            themeCacheRootURL: URL.cachesDirectory
        )
        let fakeKey = "fake-data"
        let dataURI = try SnappThemingDataURI(from: encodedImage)

        manager.setObject(dataURI.data, for: fakeKey)
        manager.store(dataURI, for: fakeKey)

        let object = try #require(manager.object(for: fakeKey, of: dataURI))
        #expect(object.url == nil)
        #expect(object.data == dataURI.data)
        let image = try #require(manager.image(from: object, of: dataURI.type))
        #expect(image.size == SnappThemingImage(data: dataURI.data)?.size)
    }

    @Test func testPreparingImage_PDF() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue,
            themeCacheRootURL: URL.cachesDirectory
        )
        let fakeKey = "fake-data"
        let dataURI = try SnappThemingDataURI(from: encodedPDF)

        manager.setObject(dataURI.data, for: fakeKey)
        manager.store(dataURI, for: fakeKey)

        let object = try #require(manager.object(for: fakeKey, of: dataURI))
        #expect(object.url == nil)
        #expect(object.data == dataURI.data)
        let _ = try #require(manager.image(from: object, of: dataURI.type))
    }

    @Test func testPreparingImage_External() throws {
        let mock = MockExternalProcessor()
        let mockImage = SnappThemingImage.system(name: "pencil")

        SnappThemingImageProcessorsRegistry.shared.register(mock)
        #expect(SnappThemingImageProcessorsRegistry.shared.registeredProcessors().count == 1)

        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue,
            themeCacheRootURL: URL.cachesDirectory
        )
        let fakeKey = "fake-data"
        let dataURI = try SnappThemingDataURI(from: encodedSVG)

        manager.setObject(dataURI.data, for: fakeKey)
        manager.store(dataURI, for: fakeKey)

        let object = try #require(manager.object(for: fakeKey, of: dataURI))
        #expect(object.url == nil)
        #expect(object.data == dataURI.data)
        let image = try #require(manager.image(from: object, of: dataURI.type))
        #expect(image.size == mockImage?.size)

        SnappThemingImageProcessorsRegistry.shared.unregister(MockExternalProcessor.self)
        #expect(SnappThemingImageProcessorsRegistry.shared.registeredProcessors().count == 0)
        
        #expect(manager.image(from: object, of: .svg) == nil)
    }

    // Failures
    @Test func testPreparingImageFromBadData() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue,
            themeCacheRootURL: URL.cachesDirectory
        )
        let fakeKey = "fake-data"
        let dataURI = SnappThemingDataURI(
            type: .png,
            encoding: .base64,
            data: try #require(encodedImage.data(using: .utf8))
        )

        manager.setObject(dataURI.data, for: fakeKey)
        manager.store(dataURI, for: fakeKey)

        let object = try #require(manager.object(for: fakeKey, of: dataURI))
        #expect(object.url == nil)
        #expect(object.data == dataURI.data)

        #expect(manager.image(from: object, of: dataURI.type) == nil)
        #expect(manager.image(from: object, of: .pdf) == nil)
        #expect(manager.image(from: object, of: .jpeg) == nil)
    }

    @Test
    func testPreparingImageObject_Failing() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue,
            themeCacheRootURL: URL(string: "dummy-url")
        )
        let dataURI = SnappThemingDataURI(
            type: .png,
            encoding: .base64,
            data: Data()
        )

        let object = manager.object(for: "dummy", of: dataURI)
        #expect(object == nil)
    }

    @Test
    func testPreparingImageObject_noCacheURLProvided_Failing() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue
        )
        let dataURI = SnappThemingDataURI(
            type: .png,
            encoding: .base64,
            data: Data()
        )

        let object = manager.object(for: "dummy", of: dataURI)
        #expect(object == nil)
    }

    @Test
    func testPreparingImageObject_noCacheURLProvidedAndStored_Failing() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .emptyCacheDirectory
        )
        let dataURI = SnappThemingDataURI(
            type: .png,
            encoding: .base64,
            data: Data()
        )

        let object = manager.object(for: "dummy", of: dataURI)
        #expect(object == nil)
    }

    @Test
    func testPreparingImageObject_failedToCrerateDirectory_Failing() throws {
        let manager: SnappThemingImageManager = SnappThemingImageManagerDefault(
            .withFileExistTrue(.failedToCreateDirectory, cachedURLs: [URL(string: "dummy-url")!])
        )
        let dataURI = SnappThemingDataURI(
            type: .png,
            encoding: .base64,
            data: Data()
        )

        let object = manager.object(for: "dummy", of: dataURI)
        #expect(object == nil)
    }
}

private let encodedImage =
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAACXBIWXMAAAOwAAADsAEnxA+tAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAA1JJREFUeJzt3T1rFFEUgOHXGAsVRIhKesEkYkzjf/CjT36KtbWVv8NCJWirVYoQECSdYGUhqBFJ0rmoRbbwY244szOZ3dzzPnBZOOLsjPfdDyx2QJIkSZIkSVL9znT8+1eA1fGjhvcF2AX2hn7iFWATGAG/XFNdI+AFsHTsjvXoAXB4ghfkmmwdAPeP2bderODmz/I6AJaLu9eDzRm4SNfx60Vx9xq0+RJ4FfgEnG3zBBrcCFgk+MVwvsWBV2ne/J/Au/HjabEMXGyYv+XoVXQazAFr48c/zQO3gTd9P+E6zW85230/0QB2aL6WNi+IWbBN83WsRw/wbz3HKX1cjFocY1Z0/f+PWVH6tw9fX5sAalJLAJ0ZQGxeLQOIzatlALF5tQwgNq+WAcTm1TKA2LxaWQMoMYAkfAcYM4DYvFoGkJwBxObVMoDYvFoGEJtXywBi82plDaDEAJLwHWDMAGLzahlAbF4tA4jNq2UAyRlAbF4tA4jNq5U1gBIDSMJ3gDEDiM2rZQCxebUMIDavlgHE5tUygOQMIDavVtYASgwgCd8BxgwgNq+WAcTm1TKA2LxaBhCbV8sAYvNqZQ2gxACSSLfRJQYQm1erj59GXQKe9nCcIV0ozJ8A+0OeSEedbxLRRwALtPht2hl3d9onMLSsHwEaM4DkDCA5A0iujy+BH4DHPRxnSE+A8w3zRxzdFue0eAhcH+rJNmi+O8XWUCfQo+80X8vNaZ7UBLZovo6N6AH8CEjOAJIzgOQMIDkDSM4AkjOA5AwgOQNIzgCSM4DkDCA5A0jOAJIzgOQMIDkDSM4AkjOA5AwgOQNIzgCSM4DkDCA5A0jOAJIzgOQMIDkDSM4AkjOA5AwgOQNIzgCSM4DkDCA5A0jOAJIzgOQMIDkDSC5rAIct59VqE8CvwryP3xse2uuG2Xvg49An0tG5wry0V/9ps3l7hfkd4C3ws8Wxpu1yw+wSsDP0iXQwB6wV/uxr9CBtbpJ0haNf0j6Nr/hMRsAi5RfsX9p8BHwFXk1yRhrUS4KbP4ll4IDmnyh3TX/tAzeKu9eTexjBLK59Brzr2RLwHPhxghfkiq0fwDMmfOV3vVPmAnALuNbxOJrMZ2AX+DbtE5EkSZIkSZI0y34Dp9katvKJ0poAAAAASUVORK5CYII="

private let encodedPDF =
    "data:application/pdf;base64,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H4cOinDa3VJgoPvAgrEMDj1FdE6RAaEXdvSd/uJLhjLX5IVGKBseIGSjnFui7ggEIlk85HAp2Wje6+gNH0xEwC6KV8QAwgphunos9qoAQQECpT09wTcM6eJKZEGfNkM2O3kZxdaNAitEiQGKEOqPa2S7L1+RNL8n+8GQgW5HCbw3b1dA6PZaFB0RvTZUK5Ezpldqjl9klUFNTh5XBa1xFDkdPvR6yXgPKB7MctFOyoKPLcRgELLutde06bVxez+yZzow06yFu16jNKrrUpxsIISUzORdxnKvXvG9mFmT3bxN2YU3IOqFc5qd22EViL70on8dyCM3O61BFjFcUUariN2GP+/amBp6idR4WS8IhniDWpE8qUCtVlu0pOUtvCXoFdAMh61lC54g1gOpqCT1kHsLCAKu0erC2pQX3IsWMIH3g9mjEbrw/n5ZmRyMk6eNpQXEA+w8Lnhh7SB7IF5kufyhmczFZAMyAxul4FinsRSAePkXrzMG7Ak2ZEP3T4TX8V//cohmvFvENmR4+eWwx57GQ/AF7OLue0IQlpV/Qi2061LX9saSTIsVSspvX5Rz33pCPghi5+ePsEuuqm+Q2O97j69P6EvITxAn79Q4vd3x9X3zCfsJNQH/Hj+Pv4/fbC3gqwplbmRzdHJlYW0KZW5kb2JqCgo2IDAgb2JqCiAgMTIwOQplbmRvYmoKCjcgMCBvYmoKICA8PCAvQW5ub3RzIFtdCiAgICAgL1R5cGUgL1BhZ2UKICAgICAvTWVkaWFCb3ggWyAwLjAwMDAwMCAwLjAwMDAwMCAyNC4wMDAwMDAgMjQuMDAwMDAwIF0KICAgICAvUmVzb3VyY2VzIDQgMCBSCiAgICAgL0NvbnRlbnRzIDUgMCBSCiAgICAgL1BhcmVudCA4IDAgUgogID4+CmVuZG9iagoKOCAwIG9iagogIDw8IC9LaWRzIFsgNyAwIFIgXQogICAgIC9Db3VudCAxCiAgICAgL1R5cGUgL1BhZ2VzCiAgPj4KZW5kb2JqCgo5IDAgb2JqCiAgPDwgL1BhZ2VzIDggMCBSCiAgICAgL1R5cGUgL0NhdGFsb2cKICA+PgplbmRvYmoKCnhyZWYKMCAxMAowMDAwMDAwMDAwIDY1NTM1IGYKMDAwMDAwMDAxMCAwMDAwMCBuCjAwMDAwMDI2OTcgMDAwMDAgbgowMDAwMDAyNzIwIDAwMDAwIG4KMDAwMDAwMjc1OCAwMDAwMCBuCjAwMDAwMDI4MTAgMDAwMDAgbgowMDAwMDA0MTAzIDAwMDAwIG4KMDAwMDAwNDEyNiAwMDAwMCBuCjAwMDAwMDQyOTkgMDAwMDAgbgowMDAwMDA0MzczIDAwMDAwIG4KdHJhaWxlcgo8PCAvSUQgWyAoc29tZSkgKGlkKSBdCiAgIC9Sb290IDkgMCBSCiAgIC9TaXplIDEwCj4+CnN0YXJ0eHJlZgo0NDMyCiUlRU9G"

let encodedSVG =
    "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjUiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNSAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTMuOTY0MzYgOC4yNzEwMkg3LjA1ODExQzcuMjIzMzMgOC45MTYzMyA3LjU5ODYzIDkuNDg4MyA4LjEyNDg0IDkuODk2NzVDOC42NTEwNCAxMC4zMDUyIDkuMjk4MjMgMTAuNTI2OSA5Ljk2NDM2IDEwLjUyNjlDMTAuNjMwNSAxMC41MjY5IDExLjI3NzcgMTAuMzA1MiAxMS44MDM5IDkuODk2NzVDMTIuMzMwMSA5LjQ4ODMgMTIuNzA1NCA4LjkxNjMzIDEyLjg3MDYgOC4yNzEwMkgyMC40NjQ0QzIwLjY2MzMgOC4yNzEwMiAyMC44NTQgOC4xOTIgMjAuOTk0NyA4LjA1MTM1QzIxLjEzNTMgNy45MTA3IDIxLjIxNDQgNy43MTk5MyAyMS4yMTQ0IDcuNTIxMDJDMjEuMjE0NCA3LjMyMjExIDIxLjEzNTMgNy4xMzEzNCAyMC45OTQ3IDYuOTkwNjlDMjAuODU0IDYuODUwMDQgMjAuNjYzMyA2Ljc3MTAyIDIwLjQ2NDQgNi43NzEwMkgxMi44NzA2QzEyLjcwNTQgNi4xMjU3MSAxMi4zMzAxIDUuNTUzNzQgMTEuODAzOSA1LjE0NTI5QzExLjI3NzcgNC43MzY4NCAxMC42MzA1IDQuNTE1MTQgOS45NjQzNiA0LjUxNTE0QzkuMjk4MjMgNC41MTUxNCA4LjY1MTA0IDQuNzM2ODQgOC4xMjQ4NCA1LjE0NTI5QzcuNTk4NjMgNS41NTM3NCA3LjIyMzMzIDYuMTI1NzEgNy4wNTgxMSA2Ljc3MTAySDMuOTY0MzZDMy43NjU0NCA2Ljc3MTAyIDMuNTc0NjggNi44NTAwNCAzLjQzNDAzIDYuOTkwNjlDMy4yOTMzNyA3LjEzMTM0IDMuMjE0MzYgNy4zMjIxMSAzLjIxNDM2IDcuNTIxMDJDMy4yMTQzNiA3LjcxOTkzIDMuMjkzMzcgNy45MTA3IDMuNDM0MDMgOC4wNTEzNUMzLjU3NDY4IDguMTkyIDMuNzY1NDQgOC4yNzEwMiAzLjk2NDM2IDguMjcxMDJaTTkuOTY0MzYgNi4wMjEwMkMxMC4yNjEgNi4wMjEwMiAxMC41NTEgNi4xMDg5OSAxMC43OTc3IDYuMjczODJDMTEuMDQ0NCA2LjQzODY0IDExLjIzNjYgNi42NzI5MSAxMS4zNTAyIDYuOTQ2OTlDMTEuNDYzNyA3LjIyMTA4IDExLjQ5MzQgNy41MjI2OCAxMS40MzU1IDcuODEzNjVDMTEuMzc3NyA4LjEwNDYzIDExLjIzNDggOC4zNzE5IDExLjAyNSA4LjU4MTY4QzEwLjgxNTIgOC43OTE0NiAxMC41NDggOC45MzQzMiAxMC4yNTcgOC45OTIyQzkuOTY2MDIgOS4wNTAwOCA5LjY2NDQyIDkuMDIwMzcgOS4zOTAzMyA4LjkwNjg0QzkuMTE2MjQgOC43OTMzMSA4Ljg4MTk3IDguNjAxMDUgOC43MTcxNSA4LjM1NDM3QzguNTUyMzMgOC4xMDc3IDguNDY0MzYgNy44MTc2OSA4LjQ2NDM2IDcuNTIxMDJDOC40NjQzNiA3LjEyMzE5IDguNjIyMzkgNi43NDE2NiA4LjkwMzcgNi40NjAzNkM5LjE4NSA2LjE3OTA1IDkuNTY2NTMgNi4wMjEwMiA5Ljk2NDM2IDYuMDIxMDJaTTIwLjQ2NDQgMTUuNzcxSDE4Ljg3MDZDMTguNzA1NCAxNS4xMjU3IDE4LjMzMDEgMTQuNTUzNyAxNy44MDM5IDE0LjE0NTNDMTcuMjc3NyAxMy43MzY4IDE2LjYzMDUgMTMuNTE1MSAxNS45NjQ0IDEzLjUxNTFDMTUuMjk4MiAxMy41MTUxIDE0LjY1MSAxMy43MzY4IDE0LjEyNDggMTQuMTQ1M0MxMy41OTg2IDE0LjU1MzcgMTMuMjIzMyAxNS4xMjU3IDEzLjA1ODEgMTUuNzcxSDMuOTY0MzZDMy43NjU0NCAxNS43NzEgMy41NzQ2OCAxNS44NSAzLjQzNDAzIDE1Ljk5MDdDMy4yOTMzNyAxNi4xMzEzIDMuMjE0MzYgMTYuMzIyMSAzLjIxNDM2IDE2LjUyMUMzLjIxNDM2IDE2LjcxOTkgMy4yOTMzNyAxNi45MTA3IDMuNDM0MDMgMTcuMDUxM0MzLjU3NDY4IDE3LjE5MiAzLjc2NTQ0IDE3LjI3MSAzLjk2NDM2IDE3LjI3MUgxMy4wNTgxQzEzLjIyMzMgMTcuOTE2MyAxMy41OTg2IDE4LjQ4ODMgMTQuMTI0OCAxOC44OTY3QzE0LjY1MSAxOS4zMDUyIDE1LjI5ODIgMTkuNTI2OSAxNS45NjQ0IDE5LjUyNjlDMTYuNjMwNSAxOS41MjY5IDE3LjI3NzcgMTkuMzA1MiAxNy44MDM5IDE4Ljg5NjdDMTguMzMwMSAxOC40ODgzIDE4LjcwNTQgMTcuOTE2MyAxOC44NzA2IDE3LjI3MUgyMC40NjQ0QzIwLjY2MzMgMTcuMjcxIDIwLjg1NCAxNy4xOTIgMjAuOTk0NyAxNy4wNTEzQzIxLjEzNTMgMTYuOTEwNyAyMS4yMTQ0IDE2LjcxOTkgMjEuMjE0NCAxNi41MjFDMjEuMjE0NCAxNi4zMjIxIDIxLjEzNTMgMTYuMTMxMyAyMC45OTQ3IDE1Ljk5MDdDMjAuODU0IDE1Ljg1IDIwLjY2MzMgMTUuNzcxIDIwLjQ2NDQgMTUuNzcxWk0xNS45NjQ0IDE4LjAyMUMxNS42Njc3IDE4LjAyMSAxNS4zNzc3IDE3LjkzMyAxNS4xMzEgMTcuNzY4MkMxNC44ODQzIDE3LjYwMzQgMTQuNjkyMSAxNy4zNjkxIDE0LjU3ODUgMTcuMDk1QzE0LjQ2NSAxNi44MjEgMTQuNDM1MyAxNi41MTk0IDE0LjQ5MzIgMTYuMjI4NEMxNC41NTExIDE1LjkzNzQgMTQuNjkzOSAxNS42NzAxIDE0LjkwMzcgMTUuNDYwNEMxNS4xMTM1IDE1LjI1MDYgMTUuMzgwNyAxNS4xMDc3IDE1LjY3MTcgMTUuMDQ5OEMxNS45NjI3IDE0Ljk5MiAxNi4yNjQzIDE1LjAyMTcgMTYuNTM4NCAxNS4xMzUyQzE2LjgxMjUgMTUuMjQ4NyAxNy4wNDY3IDE1LjQ0MSAxNy4yMTE2IDE1LjY4NzdDMTcuMzc2NCAxNS45MzQzIDE3LjQ2NDQgMTYuMjI0MyAxNy40NjQ0IDE2LjUyMUMxNy40NjQ0IDE2LjkxODggMTcuMzA2MyAxNy4zMDA0IDE3LjAyNSAxNy41ODE3QzE2Ljc0MzcgMTcuODYzIDE2LjM2MjIgMTguMDIxIDE1Ljk2NDQgMTguMDIxWiIgZmlsbD0id2hpdGUiLz4KPC9zdmc+Cg=="

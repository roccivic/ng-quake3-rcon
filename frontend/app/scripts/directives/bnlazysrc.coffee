'use strict'

###*
 # @ngdoc directive
 # @name rconApp.directive:BnLazySrc
 # @description
 # # BnLazySrc
###
# I lazily load the images, when they come into view.
angular.module('rconApp')
.directive 'bnLazySrc', ($window, $document) ->
    # I manage all the images that are currently being
    # monitored on the page for lazy loading.
    lazyLoader = do ->
        # I maintain a list of images that lazy-loading
        # and have yet to be rendered.
        images = []
        # I define the render timer for the lazy loading
        # images to that the DOM-querying (for offsets)
        # is chunked in groups.
        renderTimer = null
        renderDelay = 100
        # I cache the window element as a jQuery reference.
        win = $($window)
        # I cache the document document height so that 
        # we can respond to changes in the height due to
        # dynamic content.
        doc = $document
        documentHeight = doc.height()
        documentTimer = null
        documentDelay = 2000
        # I determine if the window dimension events 
        # (ie. resize, scroll) are currenlty being 
        # monitored for changes.
        isWatchingWindow = false
        # Return the public API.
        # ---
        # PUBLIC METHODS.
        # ---
        # I start monitoring the given image for visibility
        # and then render it when necessary.

        addImage = (image) ->
            images.push image
            if !renderTimer
                startRenderTimer()
            if !isWatchingWindow
                startWatchingWindow()
            return

        # I remove the given image from the render queue.

        removeImage = (image) ->
            # Remove the given image from the render queue.
            i = 0
            while i < images.length
                if images[i] == image
                    images.splice i, 1
                    break
                i++
            # If removing the given image has cleared the
            # render queue, then we can stop monitoring 
            # the window and the image queue.
            if !images.length
                clearRenderTimer()
                stopWatchingWindow()
            return

        # ---
        # PRIVATE METHODS.
        # ---
        # I check the document height to see if it's changed.

        checkDocumentHeight = ->
            # If the render time is currently active, then 
            # don't bother getting the document height - 
            # it won't actually do anything.
            if renderTimer
                return
            currentDocumentHeight = doc.height()
            # If the height has not changed, then ignore - 
            # no more images could have come into view.
            if currentDocumentHeight == documentHeight
                return
            # Cache the new document height.
            documentHeight = currentDocumentHeight
            startRenderTimer()
            return

        # I check the lazy-load images that have yet to 
        # be rendered. 

        checkImages = ->
            `var i`
            # Log here so we can see how often this 
            # gets called during page activity.
            console.log 'Checking for visible images...'
            visible = []
            hidden = []
            # Determine the window dimensions.
            windowHeight = win.height()
            scrollTop = win.scrollTop()
            # Calculate the viewport offsets.
            topFoldOffset = scrollTop
            bottomFoldOffset = topFoldOffset + windowHeight
            # Query the DOM for layout and seperate the
            # images into two different categories: those
            # that are now in the viewport and those that
            # still remain hidden.
            i = 0
            while i < images.length
                image = images[i]
                if image.isVisible(topFoldOffset, bottomFoldOffset)
                    visible.push image
                else
                    hidden.push image
                i++
            # Update the DOM with new image source values.
            i = 0
            while i < visible.length
                visible[i].render()
                i++
            # Keep the still-hidden images as the new 
            # image queue to be monitored.
            images = hidden
            # Clear the render timer so that it can be set
            # again in response to window changes.
            clearRenderTimer()
            # If we've rendered all the images, then stop
            # monitoring the window for changes.
            if !images.length
                stopWatchingWindow()
            return

        # I clear the render timer so that we can easily 
        # check to see if the timer is running.

        clearRenderTimer = ->
            clearTimeout renderTimer
            renderTimer = null
            return

        # I start the render time, allowing more images to
        # be added to the images queue before the render 
        # action is executed.

        startRenderTimer = ->
            renderTimer = setTimeout(checkImages, renderDelay)
            return

        # I start watching the window for changes in dimension.

        startWatchingWindow = ->
            isWatchingWindow = true
            # Listen for window changes.
            win.on 'resize.bnLazySrc', windowChanged
            win.on 'scroll.bnLazySrc', windowChanged
            # Set up a timer to watch for document-height changes.
            documentTimer = setInterval(checkDocumentHeight, documentDelay)
            return

        # I stop watching the window for changes in dimension.

        stopWatchingWindow = ->
            isWatchingWindow = false
            # Stop watching for window changes.
            win.off 'resize.bnLazySrc'
            win.off 'scroll.bnLazySrc'
            # Stop watching for document changes.
            clearInterval documentTimer
            return

        # I start the render time if the window changes.

        windowChanged = ->
            if !renderTimer
                startRenderTimer()
            return

        {
            addImage: addImage
            removeImage: removeImage
        }
    # Return the directive configuration.
    # ------------------------------------------ //
    # ------------------------------------------ //
    # I represent a single lazy-load image.

    LazyImage = (element) ->
        # I am the interpolated LAZY SRC attribute of 
        # the image as reported by AngularJS.                  
        source = null
        # I determine if the image has already been 
        # rendered (ie, that it has been exposed to the
        # viewport and the source had been loaded).
        isRendered = false
        # I am the cached height of the element. We are 
        # going to assume that the image doesn't change 
        # height over time.
        height = null
        # Return the public API.
        # ---
        # PUBLIC METHODS.
        # ---
        # I determine if the element is above the given 
        # fold of the page.

        isVisible = (topFoldOffset, bottomFoldOffset) ->
            # If the element is not visible because it 
            # is hidden, don't bother testing it.
            if !element.is(':visible')
                return false
            # If the height has not yet been calculated, 
            # the cache it for the duration of the page.
            if height == null
                height = element.height()
            # Update the dimensions of the element.
            top = element.offset().top
            bottom = top + height
            # Return true if the element is:
            # 1. The top offset is in view.
            # 2. The bottom offset is in view.
            # 3. The element is overlapping the viewport.
            top <= bottomFoldOffset and top >= topFoldOffset or bottom <= bottomFoldOffset and bottom >= topFoldOffset or top <= topFoldOffset and bottom >= bottomFoldOffset

        # I move the cached source into the live source.

        render = ->
            isRendered = true
            renderSource()
            return

        # I set the interpolated source value reported
        # by the directive / AngularJS.

        setSource = (newSource) ->
            source = newSource
            if isRendered
                renderSource()
            return

        # ---
        # PRIVATE METHODS.
        # ---
        # I load the lazy source value into the actual 
        # source value of the image element.

        renderSource = ->
            element[0].src = source
            return

        {
            isVisible: isVisible
            render: render
            setSource: setSource
        }

    # ------------------------------------------ //
    # ------------------------------------------ //
    # I bind the UI events to the scope.

    link = ($scope, element, attributes) ->
        lazyImage = new LazyImage(element)
        # Start watching the image for changes in its
        # visibility.
        lazyLoader.addImage lazyImage
        # Since the lazy-src will likely need some sort
        # of string interpolation, we don't want to 
        attributes.$observe 'bnLazySrc', (newSource) ->
            lazyImage.setSource newSource
            return
        # When the scope is destroyed, we need to remove
        # the image from the render queue.
        $scope.$on '$destroy', ->
            lazyLoader.removeImage lazyImage
            return
        return

    {
        link: link
        restrict: 'A'
    }

# ---
# generated by js2coffee 2.0.1
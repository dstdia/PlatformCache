# Boost your App with Platform Cache

        ## Learn how to leverage the platform cache to improve your app’s performance

        Presentation held at CzechDreamin' 2019 (August 16, 2019), showing a sample implementation that uses an
        Org Cache Partition to optimize database read operations of Apex code through the cache.

        Session Abstract:
        "For Web Applications, caching is a common strategy to improve perfomance and reliability.
        Yet, it’s a lesser known feature that there is “Platform Cache” as a built-in mechanism for
        Salesforce developers to add to their app design. Leveraging the Platform Cache can reduce your
        SOQL queries for certain types of data and can cut the retrieval time for data to just a few Milliseconds,
        which can effectively make access to frequently used data up to 100x faster.

        I’ll discuss how to use the platform cache, the improvement you can expect from using the
        platform cache and the limits it has."

        [Slide deck on Google Drive](https://drive.google.com/file/d/1Nin41QXY7Emtp8IB5P_6onxPwr_I6kk2/view?usp=sharing)

        ## Build with Salesforce DX

        The Repo contains prepared sample data, user setup etc. Install it into a scratch org by checking out the repo
        by running

        ````git clone github.com/dstdia/PlatformCache```

        The repo contains a setup script that creates a scratch org, assigns permissions, and prepares sample data.
        For Mac, Unix, Linux, run the following command from the command line:

        ```./createScratch.sh```

        For Windows, run the following from Powershell:

        ```./createScratch.ps1```

        ## Issues
        If you want to contribute, I'm happy to review your pull requests.
        If you have found an issue, please use the [https://github.com/dstdia/PlatformCache/issues](Issue tracker in this repo)
        ## Resources
        ###Essential Reads
        *  [Developer Documentation](bit.ly/cachedoc): bit.ly/cachedoc
        * [Trailhead](bit.ly/cachetrail): bit.ly/cachetrail

        ###Further Reading:
        * [Keir Bowden’s blog post](bit.ly/cache-buzzard)
        * [Josh Kaplan‘s blog post](bit.ly/cache-sfblog)
        * [Amit Chaudhary's blog post](http://bit.ly/cache-amit)
        * [Anil Jacob on Salesforce Developer Blog](https://developer.salesforce.com/blogs/2019/08/scaling-data-access-with-app-layer-cache.html)


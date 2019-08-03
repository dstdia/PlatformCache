# Making friends with the Platform Cache
        Sample implementation to use an Org Cache Partition to supercharge your Apex code with a cache.

        ## Dev, Build and Test
        Leverage the Included shell script to create a scratch org, push the metadata, load data and assign permissions.

        ./createScratch.sh

        Or go through the steps manually:

        **Create a scratch org**

        sfdx force:org:create -a cache -s -d 7 -f config/project-scratch-def.json

        **Push source to scratch org**
        `sfdx force:org:push`
        Either use the shell script to populate th
        Open scratch org

        sfdx force:org:open


        ## Resources
        - **Essential Reads**
        -  [Developer Documentation](bit.ly/cachedoc): bit.ly/cachedoc
        - [Trailhead](bit.ly/cachetrail): bit.ly/cachetrail

        -   **Further Reading:**
        - Keir Bowden’s blog post: bit.ly/cache-buzzard
        - Josh Kaplan‘s blog post: bit.ly/cache-sfblog
        - Amit Chaudhary's blog post: http://bit.ly/cache-amit

        ## Description of Files and Directories

        ### Main Contents
        `force-app` The main app
        ### Auxilliary Contents
        `.circleci` sample config for CircleCI
        `.pmd` rulesets for Apex PMD to validate the project against
        `src` metadata source folder for the Deploy To Salesforce button

        ## Issues
        Please report your issues. Pull requests welcome!
        [https://github.com/dstdia/PlatformCache/issues](Issue tracker in this repo)
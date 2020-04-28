# Base Maven builder with prepopulate `.m2` directory

I have been sitting here making changes to a large java application (spring-petclinic-rest) and for every change I have to rebuild my docker image. This entails downloading the whole universe from maven central. No more. It isn't possible to use volumes or mount a drive in docker build, so I've decided to use multi-stage builds to prepopulate the .m2 directory and to use this new image as my base, rather than the raw openjdk image I was previously using.

This may not suit everyone, and may not contain all the maven libraries you need. If you're doing spring-boot development then it will contain a lot of them. If it's not enough, build your own extension and copy the pattern I have here -- it's pretty easy. Hopefully this will save me, and anyone else using this, a lot of time building java/maven projects.

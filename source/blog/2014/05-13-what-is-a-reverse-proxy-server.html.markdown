---
title: What is a reverse proxy server?
tags:
published: false
---

I've learned and forgotten this a couple of times. So, I'm writing a blog post on it, pretty much just to ensure I don't forget again.

The word 'proxy' is not specific to the tech world.

Proxy is basically [defined](http://dictionary.reference.com/browse/proxy) as **the ability or authority to represent someone else**. For example, I might be authorised to sign something on behalf of my friend while he's overseas - I am my friend's proxy; my friend is signing by proxy.

In the tech world, proxy refers to one server representing another.

## An example of a (forward) proxy server
A few years ago I found myself on a network where access to gambling sites was blocked. but I wanted to see what [Kelly Slater](http://en.wikipedia.org/wiki/Kelly_Slater) was paying for the world title. So, I used a proxy server (or proxy, for short).

My computer (ie, me) wanted to access [Centrebet](http://www.centrebet.com/), which was blocked.

However, [http://www.hidemyass.com/](http://www.hidemyass.com/), a free proxy server, was not blocked.

My computer tells [HideMyAss](http://www.hidemyass.com/) that it wants to access [Centrebet](http://www.centrebet.com/). Now, my computer might be blocked from Centerbet, but it's not blocked from HideMyAss, and HideMyAss in turn is not blocked from Centerbet.

So, HideMyAss does me a favour. I tell HideMyAss that I want to access Centerbet. It accesses Centerbet for me, and passes the response back to my computer (ie, passes back the entire web page I want to view). Yay! My computer accessed Centerbet, using HideMyAss as a proxy. HideMyAss represented my computer, in it's request to Centerbet.

![forward proxy](http://upload.wikimedia.org/wikipedia/commons/1/19/Forward_proxy_h2g2bob.svg)
**Figure 1**

You could have a proxy on the same internal network as your computer, such as in the diagram above, or the proxy could be outside your own network, and open to all internet users, like this:

![open proxy](http://upload.wikimedia.org/wikipedia/commons/2/27/Open_proxy_h2g2bob.svg)
**Figure 2**

The diagram above is a particular kind of forward proxy, called an 'open proxy'. In the example I gave above, [HideMyAss](http://www.hidemyass.com/) is an open proxy. It's a forward proxy that's open to anyone on the internet - not just one specific local network.

In this diagram, the 'Internet' on the left represents my computer (since my computer is just a device connected to the internet), the Proxy is [HideMyAss](http://www.hidemyass.com/), and the 'Internet' on the right represents [Centrebet](http://www.centrebet.com/).

Note that in the example above, it was my computer and the proxy working together. The server on the end of the request, [Centrebet](http://www.centrebet.com/), was kind of oblivious. It was just happy to return a response to my proxy (the server representing me), who returned it back to me (when I say me, I mean my computer).

Now, I don't mean to confuse things, but how do you think my network was blocking access to Centerbet in the first place? Yep, they were using a proxy, like the one shown in **Figure 1**. All traffic on that network had to go out via that proxy, and that proxy blocked access to Centerbet.

So, the full request from my computer to Centerbet went something like this:

1. My computer says it wants to access HideMyAss (and I've also told HideMyAss I want it to go to Centerbet for me).
2. The local network's proxy gets the request from my computer. Now, it won't let me access Centerbet, but it will let me access HideMyAss. So, since the request is for HideMyAss, it passes it on without checking any further.
3. HideMyAss gets the request, and says 'haha you sneaky bastard, we've got you covered'. It makes the request to Centerbet for me. (Actually, it makes the request to centerbet for my local network's proxy, who in turn is innocently making it for me, despite the fact that it doesn't want me to visit centerbet!)
4. Centerbet, the innocent bystander in all this, gets the request and responds with the appropriate web page.
5. HideMyAss receives the response from Centerbet, and returns the web page back to the local network's proxy.
6. The local network's proxy things 'Hey, this is from HideMyAss, and that's not on my list of blocked sites. Fine. I'll pass it on then...'
7. My computer gets the response from the blocked Centerbet site. I win.

So, it was the *client* - my computer - and the proxy server who were working together. The final destination server was not really involved.

With a **reverse proxy**, it's the opposite.

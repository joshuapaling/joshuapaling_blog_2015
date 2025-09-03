---
title: Are LLMs Safe? Busting the Myth of "LLM Superstition"
tags:
published: true
layout: blog
---

One of the best ways to hamstring your organisation in this AI era is to fall victim to what I call **“LLM superstition.”** It’s the belief that large language models are uniquely unsafe; that info you put into ChatGPT might be regurgitated in a recognisable form in a colleague's ChatGPT session - or worse, externally to your org. It reveals a **fundamental misunderstandings** of how LLMs work.  

Failing to squash such superstition doesn't avoid risk, but it does avoid opportunity. It's on technical leaders to set the culture straight in their org.

## Training vs Inference

The biggest misunderstanding is conflating **training** with **inference**.

**Training:** The provider builds a model using large, curated datasets. This happens offline and produces a fixed set of weights, which explains why the model has a “knowledge cutoff.”

**Inference:** This is simply using the finished model. You send a prompt, it generates an output. Inference just means 'generating a response'. It does not update the model or add your input back into training.

During inference, models don’t spontaneously regurgitate arbitrary training data. They may reproduce very common text (e.g., Martin Luther King’s “I Have a Dream” speech) because it’s so frequent in the training data. But unique, private text (like your personal emails) won’t appear unless it was already in the training set. Even then, providers work to prevent rare "memorization" from leaking.

A model can be trained on any text. In theory, Google could train a model exclusively on personal emails they’ve legally agreed not to share. In practice, that would be career-ending malpractice. Reputable providers are bound by contracts, law, and hard-won trust. And, by really, really big fines when they get it wrong.

Think you don’t trust Big Tech? If you’re already using Slack, WhatsApp, Gmail, iPhones, and Amazon, you do. LLMs don’t add a new risk vector — they live inside the same trust framework you’ve been relying on for years.

## What Providers *Could* Do vs What They Actually Do

| Scenario (in theory)                                                                 | Reality (in practice)                                                                 |
|---------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| Train on **any text** they can technically access — e.g. your personal Gmail inbox.   | That would be **career-ending malpractice**. Providers are bound by contracts and laws that are very expensive to violate. |
| Secretly mix in **customer data** from enterprise products (emails, docs, chats).     | Enterprise agreements explicitly forbid this. Customer data is **not used for training**.  |
| Collect prompts at inference time and quietly add them into the model weights.        | **Inference does not update model weights.** Enterprise logs are separate, encrypted, and often zero-retention. |
| Use **private, contractually protected data** to boost accuracy without disclosure.   | Providers train on licensed datasets, public web, or opt-in corpora. Private data is **off-limits**. |
| Hope no one notices if private data leaks out verbatim during inference.              | Providers actively **test for "memorization"** and filter outputs to prevent leakage of rare/private data. |


👉 The superstition says: *“Maybe they’re secretly training on my stuff.”*  
✅ The reality is: providers know that crossing that line would destroy their credibility, violate contracts, and invite regulators with eye-watering fines.

## Myth vs Reality: Does ChatGPT Learn From My Chats?

**Myth:**  
When I type something into ChatGPT, the model is instantly “learning” from me and updating itself. My private data could leak back out in someone else's next answer.  

**Reality:**  
ChatGPT doesn’t learn in real time. The model weights are frozen during inference.  
- In the **free/Plus product**, your chats *may* be saved and later reviewed to help improve future models — unless you turn off history in settings.  
- In **Enterprise or API use**, your prompts and outputs are **never used for training** by default.  

There’s an important distinction though: **Chat history** is a feature that lets ChatGPT remember your past conversations *with you* so it can give more personalized responses (like recalling your preferences or previous context). That memory is only available to *you* in your account. It’s not the same as retraining the model, and it doesn’t affect what anyone else sees.  

And here’s the nuance: even when your chats *are* used in future training runs (in the consumer product), the risk of those details showing up elsewhere is **extremely low**. Why?  
1. **Scale of training data:** Models are trained on billions of tokens. Your individual chat is a grain of sand in a desert.  
2. **Generalisation over memorisation:** Training is designed to capture *patterns*, not rote memorisation. Unless text is common and widely published, it won’t resurface verbatim.  
3. **Safety filters:** Providers test for and actively suppress memorisation of rare, unique strings (like secrets or personal details).  

👉 What feels like “live learning” is just the model generating from patterns it already knows — not secretly retraining on your inputs. And even in the free version, where chats may help improve future models, the odds of your private details being regurgitated are vanishingly small.

## ChatGPT vs a Slack message — more similar than you’d think

Here’s the step-by-step of how a Slack message flows, then the same for an LLM request. You’ll see the bones are the same: encrypt → transmit → process → (optional) store → access under policy. LLMs use the same protocols, ciphers, and internet plumbing you already rely on every day.

### Slack message: step-by-step

	1.	Compose: You type a message in the Slack client.
	2.	Encrypt-in-transit: The client sends it over HTTPS/TLS to Slack’s servers.
	3.	Authenticate/authorise: Your identity (SSO/OAuth/cookies) is checked; workspace and channel ACLs are applied.
	4.	Process: Backend services (running on CPUs) validate payloads, apply retention/DLP rules, thread routing, notifications.
	5.	Store (optional by policy): The message is written to a database and search index, encrypted at rest.
	6.	Deliver: Other clients fetch the message over TLS, render it, and update unread counts.
	7.	Operate: Logs/metrics are captured; admins can audit according to workspace policy.

### LLM request (e.g., ChatGPT/API): step-by-step

	1.	Compose: You enter a prompt in the UI or send an API call.
	2.	Encrypt-in-transit: The client sends it over HTTPS/TLS to the provider endpoint.
	3.	Authenticate/authorise: API key/SSO is checked; org/workspace, usage limits, and feature flags are applied.
	4.	Process (stateless inference):
	•	The request hits a model gateway that validates input size, model selection, and safety settings.
	•	The prompt is fed to a running model on GPU/TPU (or CPU for small models).
	•	Important: at inference, the model does not update its weights with your prompt.
	5.	Store (configurable):
	•	Zero/limited retention options may avoid writing prompts/outputs to disk entirely.
	•	If enabled, conversation logs/metadata go to a database encrypted at rest for troubleshooting/product analytics; training usage is policy-controlled.
	6.	Deliver: The generated output is returned over TLS to the client.
	7.	Operate: Observability, safety filters (e.g., PII redaction/toxicity), rate limits, and audit logs run per your policy.

## The Same Protections You Already Trust

LLM requests and responses travel over **HTTPS/TLS**—the same encryption standards that protect banking sites, email, Jira, Slack, and Teams.
They're processed by CPUs and GPUs - the same things that process every other computational operation you perform, every day.
When logs or chat history are stored, they're stored in databases - the same tech that stores your emails, slack messages, banking records, and everything else you trust online, every day.

LLMs don’t introduce alien categories of risk. They slot into the same security model as your existing tools.

## Are There Any LLM-Specific Risks?

Sure - *different*, not necessarily *greater*. Blindly trusting output is a risk. Letting ChatGPT interact with other programs on your computer, and not checking what it's doing is a risk. A rogue driver behind the wheel is a risk, just like it is with slack, email, etc.

## What about complex agentic systems with MPC servers etc

Once you move away from the stock-standard chat tools like ChatGPT or Perplexity, and get into the world of custom-coded agentic workflows, MCP servers, etc - you get into different territory. But still, that "different territory" isn't new, unique risk. It's just the same old territory of designing a complex software system with many interacting sub-components, and ensuring it's secure.

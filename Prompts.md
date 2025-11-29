# Prompts Used to Generate Project Files

## 1. Project Initialization

I began my project by asking Claude to help me setup the IDE and innitialize the project while allowing me to learn.
Here is the first prompt.
>>
>I am a junior Software Developer. I need to create a Flutter app that generates "Quote of the Day" and displays it on the interface. I want to be able to create a multi-platform app that can run on android, IOS and web and hence the Flutter choice.
>
>I have zero experience with flutter and the Dart language. I want to learn how Flutter and Dart works while at it. At every stage of this development, explain to me what is happening and ask me questions to test my understanding. I am good with Vanilla Javascript, CSS, TailwindCSS, HTML, React, Python and Flask so you can use them for context explanation.
>
>Here is the plan/steps I want you to follow. Ask me any clarifying questions and also give me your insight on best practices:
>
>1. Walk me through the process of installing flutter and Dart in my VS Code IDE.
>2. Show me how to initialize a flutter project.
>3. Help me create a minimal working example.
>4. Suggest to me other features or ways to improve my app.
>
>Remember, the goal is to help me learn basic Flutter through this project. Deliver the lesson in small bits. Ensure I have understood one step before moving to the next.

Claude guided me while asking me clarifying questions to asses my understanding of what is happening.

[Link to Claude Conversation](<https://claude.ai/share/451a8b8e-228d-4cd0-ba0f-624e909295c1>)

---

## 2. Documentation Prompt

After building the application, I needed to create a comprehensive `README.md` file. I used Gemini CLI to generate the file within the IDE. Here is the prompt I used:

> Please create a comprehensive README.md file for my project based on the following information:
> Project name: AuraSpark
> Key features:
> • Random quotes generation
> • Refresh button for new quotes
> • Multi-Platform
>
> The README should include:
>
> 1. Clear project title and description
> 2. Tech Stack details
> 3. Project Structure
> 4. Installation requirements
> 5. Installation instructions
> 6. Basic usage examples
> 7. Features overview
> 8. Configuration options
> 9. Troubleshooting section
> 10. Contributing guidelines
> 11. License information (MIT Licence)

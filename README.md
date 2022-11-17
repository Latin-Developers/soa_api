# Ü-Feeling

## Overview

Ü-Feeling is a web app that will pull data from YouTube's API, and generate sentiment analysis based on the comments in this platform.

## Context

YouTube is a platform that generates tons of data, that generates interactive metrics for content creators to analyze the performance and reach of their videos (e.g.  number of likes, comments, views, shares, etc.). We want to provide a new approach of analysis by creating a tool that presents an idea of the perception of the commenters, meaning to somehow understand the commenters sentiment for the video based on the wording of their comments, so that we can create an overall insight of how the commenters perceive a video.

# Short-term usability goals

- Analyze the sentiment of the YouTube users
- Pull data from Youtube API, and take advantage of it
- Display daily information about the comments on the videos

# Long-term usability goals

- Create a flexible tool where you can create your own metrics inside the web app, and upload your own inputs.

# Database tables

## Entities

In this case we are planning to have 6 entities:

- categories: All the categories that exist in youtube
- videos: Record of all the videos that have been requested in the app
- videos_log: Daily record about information and some statistics of all the videos that have been requested in the app
- comments: Daily record about information and some statistics of all the comments from the videos that have been requested in the app
- authors: Information about the authors from the videos that have been requested in the app
- sentiments: Information about the sentiments that the videos can have

## Entity-Relationship Diagram

![](images/Entity_Relationship_Diagram.png)

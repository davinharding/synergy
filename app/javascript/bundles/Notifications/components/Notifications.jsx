import React, { Component } from 'react'
import axios from 'axios'

export default class Notifications extends Component {
  state = {
    messages: this.props.messages,
    profiles: this.props.profiles
  };

  fetchNotifications() {
    axios.get(`/notifications.json`).then((response) => {
      console.log(response.data)
      this.setState({
        messages: response.data.notifications,
        profiles: response.data.profiles
      })
    })
  }

  componentDidMount() {
    this.interval = setInterval(() => this.fetchNotifications(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  render() {
    return (
      <li className="nav-item dropdown">
        <a className="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          {this.state.messages} Messages
        </a>
        <div className="dropdown-menu" aria-labelledby="navbarDropdown">
          {
            this.state.profiles.map((profile) => {
              return (
                <a
                  key={profile.id}
                  className="dropdown-item"
                  href={`/profiles/${profile.id}/messages`}
                >
                  {profile.name}
                </a>
              );
            })
          }
        </div>
      </li>
    )
  }
}
import React, { Component } from 'react'

export default class Notifications extends Component {
  constructor() {
    super()
  }
  render() {
    return (
      <li className="nav-item dropdown">
        <a className="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          {this.props.messages} new messages
        </a>
        <div className="dropdown-menu" aria-labelledby="navbarDropdown">
          {
            this.props.profiles.map((profile) => {
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
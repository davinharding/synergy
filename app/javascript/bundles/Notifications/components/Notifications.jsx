import React, { Component } from 'react'

export default class Notifications extends Component {
  constructor() {
    super()
  }
  render() {
    return (
      <div>{this.props.messages} new messages</div>
    )
  }
}
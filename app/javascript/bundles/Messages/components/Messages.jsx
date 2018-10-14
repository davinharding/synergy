import React, { Component } from 'react';
import axios from 'axios';

export default class Messages extends Component {

  constructor() {
    super()
    window.messages = this;
    this.state = { messages: [], message: '' }
  }


  fetchMessages = () => {
    const { profile } = this.props;
    axios.get(`/profiles/${profile.id}/messages.json`)
      .then((response) => {
        this.setState({ messages: response.data, message: '' })
      })
  }

  handleSubmit = (e) => {
    e.preventDefault();
    const { profile } = this.props;
    const { message } = this.state;
    axios.post(`/profiles/${profile.id}/messages.json`, {
      message: { content: message }
    }, {
        headers: { 'Content-Type': 'application/json' }
      }).then((response) => {
        console.log(response.data)
        this.fetchMessages();
      })
  }

  handleMessageChange = (e) => {
    const message = e.target.value;
    this.setState({ message });
  }

  render() {
    const { messages } = this.state;
    return (
      <div style={{ height: '300px', overflowY: 'scroll' }}>
        <ul>
          {
            messages.map((message) => {
              return (
                <li key={message.id}>
                  {`(${message.sender.name})>  `}
                  {message.content}
                </li>
              )
            })
          }
        </ul>
        <form
          onSubmit={this.handleSubmit}
        >
          <input
            type="text"
            className="form-control"
            value={this.state.message}
            onChange={this.handleMessageChange}
            placeholder="Type here:"
          />
        </form>
      </div>
    )
  }

  componentDidMount() {
    this.fetchMessages();
  }

}

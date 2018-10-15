import React from 'react'
import Carousel from 'nuka-carousel'
import axios from 'axios'

class Profile extends React.Component {
  state = {
    radius: 10,
    minAge: 13,
    maxAge: 40,
    profiles: [],
    gender: "",
    activities: this.props.activities
  }

  handleGenderChange = event => {
    const gender = event.target.value;
    const { minAge, maxAge, activities, radius } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }


  handleMinAgeChange = event => {
    const minAge = event.target.value;
    const { maxAge, activities, radius, gender } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }

  handleMaxAgeChange = event => {
    const maxAge = event.target.value;
    const { minAge, activities, radius, gender } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }

  handleRadiusChange = event => {
    const radius = event.target.value;
    const { minAge, maxAge, activities, gender } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }

  fetchProfiles = (minAge, maxAge, activities, radius, gender) => {
    let activityParams = []
    activities.forEach((activity) => { activityParams.push(`activity[]=${activity}`) })
    activityParams = activityParams.join("&")
    axios.get(`/profiles.json?${activityParams}&min_age=${minAge}&max_age=${maxAge}&radius=${radius}&gender=${gender}`)
      .then((response) => {
        this.setState({
          radius,
          minAge,
          maxAge,
          activities,
          gender,
          profiles: response.data
        })
      })
  }

  handleActivityChange = (activity, active) => {
    let { activities, minAge, maxAge, radius, gender } = this.state;
    if (active) {
      activities.push(activity);
    } else {
      activities = activities.filter(a => a !== activity)
    }
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }

  componentDidMount() {
    const { minAge, maxAge, activities, radius, gender } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius, gender);
  }
  render() {
    const { profiles, minAge, maxAge, activities, radius, gender } = this.state;
    return (
      <div className="profile">
        <label className="synergy">{profiles.length} Synergies!</label>
        <Carousel
          slideIndex={1}
          swiping={true}
          decorators={[]}
        >
          {
            profiles.map((profile) => {
              return (
                <div className="profile-card" key={profile.id}>
                  <div className="photo">
                    <a className="name" href={`/profiles/${profile.id}`}>
                      <img src={profile.image_file_name} width="300" height="300" />
                    </a>
                    <p className="profile-name">{`${profile.name}, ${profile.age}`}</p>
                  </div>
                </div>
              );
            })
          }
        </Carousel>
        <div>
          {
            this.props.activities.map((activity) => {
              return (
                <span key={activity}>
                  <input
                    type="checkbox"
                    checked={activities.includes(activity)}
                    onChange={() => { this.handleActivityChange(activity, !activities.includes(activity)) }}
                  />
                  <label>{activity}</label>
                </span>
              );
            })
          }
        </div>
        <label>Gender: </label>
        <select
          className="toggle"
          type="text"
          value={gender}
          onChange={this.handleGenderChange}
        >
          <option value="">Both</option>
          <option value="male">Male</option>
          <option value="female">Female</option>
        </select>
        <label>Age Range: </label>
        <input
          className="toggle"
          size="10"
          type="number"
          value={minAge}
          onChange={this.handleMinAgeChange}
        />
        <label htmlFor="to"> to </label>
        <input
          className="toggle"
          type="number"
          value={maxAge}
          onChange={this.handleMaxAgeChange}
        />
        <div>
          <input
            className="toggle"
            type="number"
            value={radius}
            onChange={this.handleRadiusChange}
          />
          <label> miles away</label>
        </div>
      </div>
    );
  }
}

export default Profile

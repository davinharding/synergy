import React from 'react'
import Carousel from 'nuka-carousel'
import axios from 'axios'

class Profile extends React.Component {
  state = {
    radius: 10,
    minAge: 13,
    maxAge: 100,
    profiles:   [],
    activities: this.props.activities
  }

  handleMinAgeChange = event => {
    const minAge = event.target.value;
    const { maxAge, activities, radius } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius);
  }

  handleMaxAgeChange = event => {
    const maxAge = event.target.value;
    const { minAge, activities, radius } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius);
  }

  handleRadiusChange = event => {
    const radius = event.target.value;
    const { minAge, maxAge, activities } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius);
  }

  fetchProfiles = (minAge, maxAge, activities, radius) => {
    let activityParams = []
    activities.forEach((activity) => { activityParams.push(`activity[]=${activity}`) })
    activityParams = activityParams.join("&")
    axios.get(`/profiles.json?${activityParams}&min_age=${minAge}&max_age=${maxAge}&radius=${radius}`)
      .then((response) => {
        console.log(response.data.length)
        this.setState({
          radius,
          minAge,
          maxAge,
          activities,
          profiles: response.data
        })
      })
  }

  handleActivityChange = (activity, active) => {
    let { activities, minAge, maxAge, radius } = this.state;
    if(active){
      activities.push(activity);
    }else{
      activities = activities.filter(a => a !== activity)
    }
    this.fetchProfiles(minAge, maxAge, activities, radius);
  }

  componentDidMount() {
    const { minAge, maxAge, activities, radius } = this.state;
    this.fetchProfiles(minAge, maxAge, activities, radius);
  }
    render() {
      const { profiles, minAge, maxAge, activities, radius } = this.state;
      return (
        <div className="profile">
          <p>{profiles.length} Synergies!</p>
          <input
            type="number"
            value={minAge}
            onChange={this.handleMinAgeChange}
          />
          <input
            type="number"
            value={maxAge}
            onChange={this.handleMaxAgeChange}
          />
          {
            this.props.activities.map((activity) => {
              return(
                <div key={activity}>
                  <input
                    type="checkbox"
                    checked={activities.includes(activity)}
                    onChange={ () => { this.handleActivityChange(activity, !activities.includes(activity))} }
                  />
                  <label>{activity}</label>
                </div>
              );
            })
          }
          <input
            type="number"
            value={radius}
            onChange={this.handleRadiusChange}
          />
          <Carousel>
            {
              profiles.map((profile) => {
                return(
                  <div key={profile.id}>
                    <img src={profile.image_file_name} />
                    <p><a href={`/profiles/${profile.id}`}>{ profile.name }</a></p>
                    <p>{ profile.age }</p>
                    <p> {this.props.activities} </p>
                    <p>  </p>
                  </div>
                );
              })
            }
          </Carousel>
        </div>
      );
    }
}

export default Profile

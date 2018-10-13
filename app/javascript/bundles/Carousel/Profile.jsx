import React from 'react'
import Carousel from 'nuka-carousel'
import axios from 'axios'

class Profile extends React.Component {
  state = {
    radius: 10,
    minAge: 13,
    maxAge: 40,
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
          <Carousel
            slideIndex={1}
            swiping={true}
            decorators={[]}
            renderBottomLeftControls={({ previousSlide }) => (
              <button onClick={previousSlide}>Previous</button>
            )}
            renderBottomRightControls={({ nextSlide }) => (
              <button onClick={nextSlide}>Next</button>
            )}
          >
            >
            {
              profiles.map((profile) => {
                return(
                  <div className="profile-card" key={profile.id}>
                   <div className ="photo"><a href={`/profiles/${profile.id}`}><img src={profile.image_file_name} width="300" height="300"/></a>
                    <p className="profile-name"><a href={`/profiles/${profile.id}`}>{ profile.name }{ profile.age }</a></p>
                    </div> 
                    {/* <p className="card-activities"> <ul>{this.props.activities.map(activity=><li>{activity}</li>)}</ul></p>
                     */}
                    
                    <p>  </p>
                  </div>
                );
              })
            }
          </Carousel>
          {/* <label for="age range">Age Range: </label> */}
          <input
            input 
            maxlength="10"
            type="number"
            value={minAge}
            onChange={this.handleMinAgeChange}
          />
          <label for="to"> to </label>
          <input
            type="number"
            value={maxAge}
            onChange={this.handleMaxAgeChange}
           
          />
          
          <label for="radius">Radius: </label>
          <input
            type="number"
            value={radius}
            onChange={this.handleRadiusChange}
          />
          <span> mi</span>
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
        </div>
      );
    }
}

export default Profile

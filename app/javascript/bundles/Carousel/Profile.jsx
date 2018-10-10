import React from 'react'
import Carousel from 'nuka-carousel'
import axios from 'axios'

class Profile extends React.Component {
  constructor(){
    super();
    this.state = {
      profiles: [],
      activities: []
    }
  }

  async componentDidMount() {
    let profiles;
    let activities;
    profiles = await axios.get('./profiles.json')
    activities = await axios.get('./activities.json')
    profiles = await profiles.data;
    activities = await activities.data;
    this.setState({profiles, activities})
    // console.log(this.state.activities)
    // profiles = await profiles.map((profile, i) => {
    //   profile.activities = activities[i]
    // })
    // console.log(profiles)

    // activities.reverse().map(activity => {
    //   profiles.map(profile => {
    //     profile.activities = activity
    //   })
    // })
    // this.setState({profiles}) 
    // console.log(this.state.profiles)
  }
    render() {
        return (
          <div className="profile">
            {
              this.state.profiles.map((profile,i) => {
                profile.activities = this.state.activities[i]
              })
            }
            {console.log(this.state.profiles)}
            <Carousel>
              {this.state.profiles.map(profile=>profile.name)}
              {/* How do I get more then one element to render above? */}
            </Carousel>
          </div>
        );
    }
}

export default Profile

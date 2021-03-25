import React, { Component } from 'react';
import { Form, FormGroup, Input, Label, Button } from 'reactstrap';
import { post } from '../utils/helper';

export default class FeedbackForm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      name: '',
      comment: '',
      alert: ''
    };

    this.submitForm = this.submitForm.bind(this);
  }

  onNameChange = (e) => {
    this.setState({
      name: e.target.value
    });
  };

  onCommentChange = (e) => {
    this.setState({
      comment: e.target.value
    });
  };

  submitForm() {
    return post('/api/feedbacks', { name: this.state.name, comment: this.state.comment })
      .then(() => {
        this.setState({
          alert: 'Successfully Submitted'
        });
      })
      .catch(() => {
        this.setState({
          alert: 'Could not submit feedback'
        });
      })
      .finally(() => {
        this.setState({
          name: '',
          comment: ''
        });
      });
  }

  render() {
    return (
      <Form className="col-md-6 offset-3">
        <h6 id="message" className="center">{ this.state.alert }</h6>
        <FormGroup>
          <Label for="name">Name</Label>
          <Input
            type="text"
            name="name"
            id="name"
            placeholder="Name"
            value={this.state.name}
            onChange={this.onNameChange}
          />
        </FormGroup>
        <FormGroup>
          <Label for="comments">Comments</Label>
          <Input
            type="textarea"
            name="comments"
            id="comments"
            placeholder="Comments"
            value={this.state.comment}
            onChange={this.onCommentChange}
          />
        </FormGroup>
        <Button onClick={this.submitForm}> Submit </Button>
      </Form>
    );
  }
}

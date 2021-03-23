import React from 'react';
import { Form, FormGroup, Input, Label } from 'reactstrap';

export default function FeedbackForm() {
  return (
    <Form className="col-md-6 offset-3">
      <FormGroup>
        <Label for="name">Name</Label>
        <Input type="text" name="name" id="name" placeholder="Name" />
      </FormGroup>
      <FormGroup>
        <Label for="comments">Comments</Label>
        <Input type="textarea" name="comments" id="comments" placeholder="Comments" />
      </FormGroup>
    </Form>
  );
}

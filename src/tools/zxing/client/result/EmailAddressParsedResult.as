package tools.zxing.client.result
{
	import tools.zxing.common.flexdatatypes.StringBuilder;
	
/*
 * Copyright 2007 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * @author Sean Owen
 */
public final class EmailAddressParsedResult extends ParsedResult 
{

  private var emailAddress:String;
  private var subject:String;
  private var body:String;
  private var mailtoURI:String;

  public function EmailAddressParsedResult(emailAddress:String, subject:String, body:String , mailtoURI:String )
   {
    super(ParsedResultType.EMAIL_ADDRESS);
    this.emailAddress = emailAddress;
    this.subject = subject;
    this.body = body;
    this.mailtoURI = mailtoURI;
  }

  public function getEmailAddress():String 
  {
    return emailAddress;
  }

  public function getSubject():String 
  {
    return subject;
  }

  public function getBody():String 
  {
    return body;
  }

  public function getMailtoURI():String 
  {
    return mailtoURI;
  }

  public override function getDisplayResult():String 
  {
    var result:StringBuilder = new StringBuilder();
    maybeAppend(emailAddress, result);
    maybeAppend(subject, result);
    maybeAppend(body, result);
    return result.toString();
  }

}}
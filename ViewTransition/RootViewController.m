/*****************************************************************************
 *
 * FILE:	RootViewController.m
 * DESCRIPTION:	ViewTransition: Root View Controller
 * DATE:	Tue, May 28 2013
 * UPDATED:	Tue, May 28 2013
 * AUTHOR:	Kouichi ABE (WALL) / 阿部康一
 * E-MAIL:	kouichi@MagickWorX.COM
 * URL:		http://www.MagickWorX.COM/
 * COPYRIGHT:	(c) 2013 阿部康一／Kouichi ABE (WALL), All rights reserved.
 * LICENSE:
 *
 *  Copyright (c) 2013 Kouichi ABE (WALL) <kouichi@MagickWorX.COM>,
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 *   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 *   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 *   PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
 *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *   INTERRUPTION)  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 *   THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Id: RootViewController.m,v 1.2 2013/01/22 15:23:51 kouichi Exp $
 *
 *****************************************************************************/

#import "RootViewController.h"
#import "TransitionUIKitViewController.h"
#import "TransitionQuartzCoreViewController.h"
#import "PageViewController.h"

enum {
  kTransitionUIKit,
  kTransitionQuartzCore,
  kTransitionPageViewControl,
  kNumberOfTransitions
};

@interface RootViewController ()
{
@private
  NSArray *	_data;
}
@property (nonatomic,retain) NSArray *	data;
@end

@implementation RootViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"Transition", @"");
  }
  return self;
}

-(void)dealloc
{
  [_data release];
  [super dealloc];
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)viewDidLoad
{
  [super viewDidLoad];

  self.data = @[ @"UIKit", @"QuartzCore", @"PageViewController" ];

  UITableView *	tableView;
  tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  tableView.delegate	= self;
  tableView.dataSource	= self;
  self.tableView	= tableView;
  [tableView release];
}

/*****************************************************************************/

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section
{
  return self.data.count;
}

#pragma mark UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *	cellIdentifier = @"TransitionTableCellIdentifier";

  UITableViewCell *	cell;
  cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]
	    initWithStyle:UITableViewCellStyleDefault
	    reuseIdentifier:cellIdentifier];
    [cell autorelease];
  }
  cell.accessoryType	= UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text	= [self.data objectAtIndex:[indexPath row]];

  return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];


  NSAutoreleasePool *	pool = [[NSAutoreleasePool alloc] init];

  UIViewController *	viewController = nil;
  switch ([indexPath row]) {
    case kTransitionUIKit: {
	TransitionUIKitViewController *	vc;
	vc = [TransitionUIKitViewController new];
	viewController = vc;
      }
      break;
    case kTransitionQuartzCore: {
	TransitionQuartzCoreViewController *	vc;
	vc = [TransitionQuartzCoreViewController new];
	viewController = vc;
      }
      break;
    case kTransitionPageViewControl: {
	PageViewController *	vc;
	vc = [PageViewController new];
	viewController = vc;
      }
      break;
  }
  if (viewController != nil) {
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
  }

  [pool drain];
}

@end

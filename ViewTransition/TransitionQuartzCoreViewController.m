/*****************************************************************************
 *
 * FILE:	TransitionQuartzCoreViewController.h
 * DESCRIPTION:	ViewTransition: Transition View Controller with QuarzCore
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
 * $Id: TransitionQuartzCoreViewController.m,v 1.2 2013/01/22 15:23:51 kouichi Exp $
 *
 *****************************************************************************/

#import <QuartzCore/QuartzCore.h>
#import "TransitionQuartzCoreViewController.h"

@interface TransitionQuartzCoreViewController ()
{
@private
  UIImageView *	_imageView1;
  UIImageView *	_imageView2;
}
@property (nonatomic,retain) UIImageView *	imageView1;
@property (nonatomic,retain) UIImageView *	imageView2;
@end

@implementation TransitionQuartzCoreViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"QuartzCore", @"");
  }
  return self;
}

-(void)dealloc
{
  [_imageView1 release];
  [_imageView2 release];
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

  CGRect	frame = self.view.bounds;
  frame.size.height  -= self.navigationController.navigationBar.bounds.size.height;

  UIImageView *	imageView;
  imageView = [[UIImageView alloc]
		initWithImage:[UIImage imageNamed:@"image1.jpeg"]];
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView1 = imageView;
  [self.view addSubview:imageView];
  [imageView release];

  imageView = [[UIImageView alloc]
		initWithImage:[UIImage imageNamed:@"image2.jpeg"]];
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView2 = imageView;
  [imageView release];


  NSMutableArray *	items = [NSMutableArray new];
  UIBarButtonItem *	flexItem;
  flexItem = [[UIBarButtonItem alloc]
	      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
	      target:nil
	      action:nil];

  UIBarButtonItem *	fadeItem;
  fadeItem = [[UIBarButtonItem alloc]
	      initWithTitle:@"Fade"
	      style:UIBarButtonItemStyleBordered
	      target:self
	      action:@selector(fadeAction:)];
  [items addObject:fadeItem];
  [fadeItem release];
  [items addObject:flexItem];

  UIBarButtonItem *	moveInItem;
  moveInItem = [[UIBarButtonItem alloc]
		initWithTitle:@"MoveIn"
		style:UIBarButtonItemStyleBordered
		target:self
		action:@selector(moveInAction:)];
  [items addObject:moveInItem];
  [moveInItem release];
  [items addObject:flexItem];

  UIBarButtonItem *	pushItem;
  pushItem = [[UIBarButtonItem alloc]
	      initWithTitle:@"Push"
	      style:UIBarButtonItemStyleBordered
	      target:self
	      action:@selector(pushAction:)];
  [items addObject:pushItem];
  [pushItem release];
  [items addObject:flexItem];

  UIBarButtonItem *	revealItem;
  revealItem = [[UIBarButtonItem alloc]
		initWithTitle:@"Reveal"
		style:UIBarButtonItemStyleBordered
		target:self
		action:@selector(revealAction:)];
  [items addObject:revealItem];
  [revealItem release];
  [flexItem release];

  [self setToolbarItems:items animated:NO];
  [items release];
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  self.navigationController.toolbarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
  self.navigationController.toolbarHidden = YES;

  [super viewWillDisappear:animated];
}

/*****************************************************************************/

-(void)transitionWithType:(NSString *)type subtype:(NSString *)subtype
{
  CATransition *	transition = [CATransition animation];
  transition.duration	= 1.0f;
  transition.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  transition.type	= type;
  transition.subtype	= subtype;


  UIView *	fromView;
  UIView *	toView;

  if ([self.imageView1 superview] != nil) {
    fromView = self.imageView1;
    toView   = self.imageView2;
  }
  else {
    fromView = self.imageView2;
    toView   = self.imageView1;
  }
  [fromView removeFromSuperview];
  [self.view addSubview:toView];
  [self.view.layer addAnimation:transition forKey:nil];
}

#pragma mark UIBarButtonItem action
-(void)fadeAction:(id)sender
{
  [self transitionWithType:kCATransitionFade subtype:nil];
}

#pragma mark UIBarButtonItem action
-(void)moveInAction:(id)sender
{
  NSString *	subtype;

  if ([self.imageView1 superview] != nil) {
    subtype = kCATransitionFromLeft;
  }
  else {
    subtype = kCATransitionFromRight;
  }
  [self transitionWithType:kCATransitionMoveIn subtype:subtype];
}

#pragma mark UIBarButtonItem action
-(void)pushAction:(id)sender
{
  NSString *	subtype;

  if ([self.imageView1 superview] != nil) {
    subtype = kCATransitionFromLeft;
  }
  else {
    subtype = kCATransitionFromRight;
  }
  [self transitionWithType:kCATransitionPush subtype:subtype];
}

#pragma mark UIBarButtonItem action
-(void)revealAction:(id)sender
{
  NSString *	subtype;

  if ([self.imageView1 superview] != nil) {
    subtype = kCATransitionFromLeft;
  }
  else {
    subtype = kCATransitionFromRight;
  }
  [self transitionWithType:kCATransitionReveal subtype:subtype];
}

@end

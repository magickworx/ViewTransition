/*****************************************************************************
 *
 * FILE:	ContentsViewController.m
 * DESCRIPTION:	ViewTransition: Contents View Controller for UIPageViewController
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
 * $Id: ContentsViewController.m,v 1.2 2013/01/22 15:23:51 kouichi Exp $
 *
 *****************************************************************************/

#import "ContentsViewController.h"

@interface ContentsViewController ()
{
@private
  UILabel *	_label;
}
@property (nonatomic,retain) UILabel *	label;
@end

@implementation ContentsViewController

-(id)init
{
  self = [super init];
  if (self) {
    self.title = NSLocalizedString(@"ContentsViewController", @"");
  }
  return self;
}

-(void)dealloc
{
  [_label release];
  [super dealloc];
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)loadView
{
  [super loadView];

  self.view.backgroundColor	= [UIColor whiteColor];

  CGFloat	w = self.view.bounds.size.width;
  CGFloat	h = 80.0f;
  CGFloat	x = 0.0f;
  CGFloat	y = (self.view.bounds.size.height - h) * 0.5f;

  UILabel *	label;
  label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
  label.backgroundColor	= [UIColor clearColor];
  label.textAlignment	= NSTextAlignmentCenter;
  label.font = [UIFont boldSystemFontOfSize:32.0f];
  label.text = @"Page#001";
  [self.view addSubview:label];
  self.label = label;
  [label release];
}

-(void)viewDidLoad
{
  [super viewDidLoad];
}

/*****************************************************************************/

-(void)setPageIndex:(NSInteger)pageIndex
{
  self.label.text = [NSString stringWithFormat:@"Page#%03d", pageIndex];
}

@end
